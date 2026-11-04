#!/usr/bin/env bash
#
# export-n8n-workflows.sh
# Exporta todos los workflows de una instancia n8n y los deja listos en ./workflows
# para subirlos a GitHub.
#
# Uso (modo API, recomendado):
#   export N8N_URL="https://n8n.tudominio.com"
#   export N8N_API_KEY="eyJhbGciOi..."      # n8n > Settings > n8n API > Create API key
#   ./scripts/export-n8n-workflows.sh
#
# Uso (modo CLI, si corres n8n en Docker en el mismo VPS):
#   ./scripts/export-n8n-workflows.sh --docker n8n
#
# Uso (modo CLI, si n8n esta instalado con npm en el host):
#   ./scripts/export-n8n-workflows.sh --cli
#
set -euo pipefail

OUT_DIR="${OUT_DIR:-workflows}"
MODE="api"
CONTAINER=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --docker) MODE="docker"; CONTAINER="${2:?falta el nombre del contenedor}"; shift 2 ;;
    --cli)    MODE="cli"; shift ;;
    --api)    MODE="api"; shift ;;
    --out)    OUT_DIR="${2:?falta la ruta}"; shift 2 ;;
    -h|--help) sed -n '2,20p' "$0"; exit 0 ;;
    *) echo "Opcion desconocida: $1" >&2; exit 2 ;;
  esac
done

need() { command -v "$1" >/dev/null 2>&1 || { echo "Falta la herramienta '$1'. Instalala primero." >&2; exit 1; }; }
need jq

# Convierte un nombre en un nombre de archivo seguro.
# Usa python3 si existe (quita acentos correctamente); si no, cae a ASCII puro.
if command -v python3 >/dev/null 2>&1; then
  slugify() {
    printf '%s' "$1" | python3 -I -c '
import sys, re, unicodedata
t = unicodedata.normalize("NFKD", sys.stdin.read())
t = t.encode("ascii", "ignore").decode("ascii").lower()
t = re.sub(r"[^a-z0-9]+", "-", t).strip("-")
sys.stdout.write(t[:80])
'
  }
else
  slugify() {
    printf '%s' "$1" | tr '[:upper:]' '[:lower:]' \
      | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//' | cut -c1-80
  }
fi

mkdir -p "$OUT_DIR"
RAW="$(mktemp -d)"
trap 'rm -rf "$RAW"' EXIT

# ---------------------------------------------------------------- recoleccion
case "$MODE" in
  api)
    : "${N8N_URL:?Define N8N_URL (ej. https://n8n.tudominio.com)}"
    : "${N8N_API_KEY:?Define N8N_API_KEY}"
    BASE="${N8N_URL%/}/api/v1/workflows"
    CURSOR=""
    PAGE=0
    while :; do
      PAGE=$((PAGE+1))
      URL="${BASE}?limit=100"
      [[ -n "$CURSOR" ]] && URL="${URL}&cursor=${CURSOR}"
      echo "Descargando pagina ${PAGE}..." >&2
      HTTP_BODY="$RAW/page-${PAGE}.json"
      CODE=$(curl -sS -o "$HTTP_BODY" -w '%{http_code}' \
                  -H "X-N8N-API-KEY: ${N8N_API_KEY}" \
                  -H 'Accept: application/json' "$URL")
      if [[ "$CODE" != "200" ]]; then
        echo "Error HTTP ${CODE} consultando ${URL}" >&2
        head -c 500 "$HTTP_BODY" >&2; echo >&2
        exit 1
      fi
      jq -c '.data[]' "$HTTP_BODY" >> "$RAW/all.ndjson"
      CURSOR=$(jq -r '.nextCursor // empty' "$HTTP_BODY")
      [[ -z "$CURSOR" ]] && break
    done
    ;;
  docker)
    echo "Exportando con el CLI de n8n dentro del contenedor '${CONTAINER}'..." >&2
    docker exec "$CONTAINER" sh -lc 'rm -rf /tmp/n8n-export && mkdir -p /tmp/n8n-export && n8n export:workflow --all --separate --output=/tmp/n8n-export'
    docker cp "${CONTAINER}:/tmp/n8n-export/." "$RAW/"
    for f in "$RAW"/*.json; do [[ -e "$f" ]] || continue; jq -c '.' "$f" >> "$RAW/all.ndjson"; done
    ;;
  cli)
    echo "Exportando con el CLI de n8n local..." >&2
    need n8n
    n8n export:workflow --all --separate --output="$RAW/cli"
    for f in "$RAW"/cli/*.json; do [[ -e "$f" ]] || continue; jq -c '.' "$f" >> "$RAW/all.ndjson"; done
    ;;
esac

[[ -s "$RAW/all.ndjson" ]] || { echo "No se encontro ningun workflow." >&2; exit 1; }

# ------------------------------------------------------- limpieza + escritura
# Quita campos volatiles y cualquier parametro que parezca un secreto.
SCRUB='
  def scrub:
    walk(
      if type == "object" then
        with_entries(
          if (.key | ascii_downcase | test("^token$|^auth$|^credentials$|apikey|api_key|accesstoken|access_token|refreshtoken|refresh_token|clientsecret|client_secret|password|passwd|secret|privatekey|private_key|bearer|authorization|sessionid|session_id|webhookid"))
             and (.value | type == "string") and (.value | length > 0)
          then .value = "__REDACTED__"
          else . end
        )
      else . end
    );
  {
    id, name, active,
    nodes, connections, settings,
    staticData: (.staticData // null),
    pinData: (.pinData // null),
    tags: [ (.tags // [])[] | if type=="object" then .name else . end ],
    meta: (.meta // null)
  } | scrub
'

: > "$RAW/index.ndjson"
COUNT=0
while IFS= read -r line; do
  NAME=$(printf '%s' "$line" | jq -r '.name // "sin-nombre"')
  ID=$(printf '%s' "$line"   | jq -r '.id // "noid"')
  ACTIVE=$(printf '%s' "$line" | jq -r 'if .active then "activo" else "inactivo" end')
  SLUG=$(slugify "$NAME")
  [[ -z "$SLUG" ]] && SLUG="workflow"
  FILE="${SLUG}.${ID}.json"
  printf '%s' "$line" | jq -S "$SCRUB" > "${OUT_DIR}/${FILE}"
  NODES=$(printf '%s' "$line" | jq -r '(.nodes // []) | length')
  jq -nc --arg name "$NAME" --arg file "$FILE" --arg state "$ACTIVE" \
         --arg id "$ID" --argjson nodes "${NODES:-0}" \
         '{name:$name,file:$file,state:$state,id:$id,nodes:$nodes}' >> "$RAW/index.ndjson"
  COUNT=$((COUNT+1))
done < "$RAW/all.ndjson"

# ------------------------------------------------------------------- indice
{
  echo "# Workflows de n8n"
  echo
  echo "Exportados el $(date -u '+%Y-%m-%d %H:%M UTC') — **${COUNT} workflows**."
  echo
  echo "| # | Workflow | Estado | Nodos | Archivo |"
  echo "|---|----------|--------|-------|---------|"
  i=0
  while IFS= read -r row; do
    i=$((i+1))
    n=$(printf '%s' "$row" | jq -r .name)
    f=$(printf '%s' "$row" | jq -r .file)
    s=$(printf '%s' "$row" | jq -r .state)
    k=$(printf '%s' "$row" | jq -r .nodes)
    printf '| %s | %s | %s | %s | [`%s`](./%s) |\n' "$i" "$n" "$s" "$k" "$f" "$f"
  done < <(sort -t'"' -k4 "$RAW/index.ndjson")
  echo
  echo "> Los valores que parecian credenciales se reemplazaron por \`__REDACTED__\`."
  echo "> Revisa los archivos antes de hacer el repositorio publico."
} > "${OUT_DIR}/README.md"

echo
echo "Listo: ${COUNT} workflows en ${OUT_DIR}"
echo "Indice: ${OUT_DIR}/README.md"
echo
echo "Siguiente paso:"
echo "  git add ${OUT_DIR} && git commit -m 'Agrega workflows de n8n' && git push -u origin HEAD"
