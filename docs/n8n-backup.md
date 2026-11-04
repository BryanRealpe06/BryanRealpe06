# Respaldar los workflows de n8n en este repositorio

Guía para exportar todos los workflows de una instancia de n8n y versionarlos
en GitHub, usando `scripts/export-n8n-workflows.sh`.

## Antes de empezar

En el VPS necesitas `git`, `curl` y `jq`:

```bash
sudo apt update && sudo apt install -y git curl jq
```

## 1. Clona el repositorio en el VPS

```bash
git clone https://github.com/BryanRealpe06/BryanRealpe06.git
cd BryanRealpe06
git checkout claude/n8n-workflows-github-km739l
```

## 2. Exporta los workflows

Elige **uno** de los tres modos.

### Modo A — API pública de n8n (recomendado)

Crea una API key en n8n: **Settings → n8n API → Create an API key**.

```bash
export N8N_URL="https://n8n.tudominio.com"   # o http://localhost:5678
export N8N_API_KEY="pega-aqui-tu-api-key"
./scripts/export-n8n-workflows.sh
```

### Modo B — n8n en Docker

```bash
docker ps                      # busca el nombre del contenedor
./scripts/export-n8n-workflows.sh --docker n8n
```

### Modo C — n8n instalado con npm

```bash
./scripts/export-n8n-workflows.sh --cli
```

En los tres casos el resultado queda en `workflows/`: un `.json` por workflow
más un `README.md` con una tabla índice y enlaces a cada archivo.

## 3. Revisa antes de subir

El script reemplaza por `__REDACTED__` todo parámetro cuyo nombre parezca un
secreto (`apiKey`, `password`, `token`, `authorization`, `clientSecret`…).
**Aun así revisa los archivos**: un secreto escrito dentro de una expresión, o
en un campo con nombre inocente, no se detecta.

```bash
git status --short
grep -ril -E 'sk-|ghp_|xoxb-|AKIA|Bearer ' workflows/   # no debería devolver nada
```

Si todo está limpio:

```bash
git add workflows
git commit -m "Respaldo de workflows de n8n"
git push -u origin claude/n8n-workflows-github-km739l
```

## 4. Automatizarlo (opcional)

Para un respaldo diario a las 3:00 a.m., deja configuradas las credenciales de
git en el remoto y añade esto a `crontab -e`:

```cron
0 3 * * * cd /ruta/a/BryanRealpe06 && N8N_URL="https://n8n.tudominio.com" N8N_API_KEY="tu-key" ./scripts/export-n8n-workflows.sh >> /var/log/n8n-backup.log 2>&1 && git add workflows && git -c user.name="n8n backup" -c user.email="tu@correo" commit -q -m "Respaldo automatico" && git push -q origin claude/n8n-workflows-github-km739l
```

Guarda la API key en un archivo con permisos `600` y cárgala desde ahí en vez
de escribirla en el crontab, que es legible por el dueño del archivo.

## Lo que **no** se exporta

Los workflows guardan solo la *referencia* a sus credenciales (id y nombre),
nunca el secreto en sí. Al restaurar en otra instancia tendrás que volver a
crear las credenciales y reasignarlas. Eso es intencional: así el respaldo se
puede versionar sin exponer llaves.

## Restaurar

```bash
# Modo CLI
n8n import:workflow --separate --input=workflows/

# Modo Docker
docker cp workflows/. n8n:/tmp/wf/
docker exec n8n n8n import:workflow --separate --input=/tmp/wf
```
