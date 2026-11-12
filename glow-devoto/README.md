# Glow Devoto — landing con embudo de ventas

Sitio estático. Sin build, sin npm. Se sube arrastrando la carpeta a Hostinger,
Netlify o cualquier hosting estático.

```
index.html   styles.css   main.js   .htaccess
```

Si editás CSS o JS, subí el `?v=20261112b` de `index.html`.

---

## ⚠️ LO QUE HAY QUE COMPLETAR ANTES DE PUBLICAR

Todo lo pendiente está **resaltado en ámbar con línea punteada** en la página
(`[data-editar]`). No se puede publicar así: hay ofertas y promesas que inventé
y que el negocio tiene que confirmar o cambiar.

| Dónde | Qué falta | Por qué importa |
|---|---|---|
| Hero y Oferta | **El «20% off»** | Lo inventé. Es el motor del embudo: sin una oferta real no hay conversión |
| Oferta | **Escasez real** | Cupos que de verdad queden. Nunca un contador falso |
| Oferta | Beneficio extra | Opcional, borrar si no hay |
| Garantía | **«Si no quedás conforme no pagás»** | Es una promesa comercial. Si no la sostienen, se cambia |
| FAQ | **Protocolo de higiene** | Lo dejé en blanco a propósito: no sé cómo trabajan |
| Confianza | «Material descartable» | Confirmar |
| Prueba social | **3 reseñas reales** | Copiarlas de su perfil de Google, con nombre y mes |
| Cierre | Horarios | — |
| Footer | Instagram | — |

## El embudo

La versión anterior era una página institucional linda, sin embudo. Esta sigue
una estructura de conversión:

1. **Hero** — oferta + prueba social + botón, todo en la primera pantalla del
   teléfono sin scrollear.
2. **Barra de confianza** — reseñas, sala privada, zona.
3. **Problema** — las cuatro razones por las que alguien posterga el turno.
4. **Solución** — los 5 pasos del turno, y un CTA al final.
5. **Oferta** — qué incluye, escasez, botón.
6. **Prueba social** — puntaje y reseñas.
7. **Objeciones** — las preguntas incómodas.
8. **Reversión de riesgo** — la garantía.
9. **Cierre** — CTA final, dirección, horarios, mapa.

Decisiones tomadas por investigación del rubro:

- **Sin menú de navegación.** En una landing de conversión, los links del menú
  se llevan gente del embudo. Arriba solo queda el botón.
- **Barra fija abajo en móvil** (Pedir turno · Llamar · Llegar), en la zona del
  pulgar.
- **El CTA se repite 6 veces**, en cada punto de decisión.
- **Escasez real, nunca falsa.** Un contador regresivo inventado da un empujón
  corto y daña la marca.
- **Sin seña.** Menos fricción para reservar.

## Paleta

Cálida y clara: crema `#fdf6ee`, arena `#f8e9d7`, barro `#f1d7bd`, tinta
`#3a2217`, acento `#c4551f`. Tipografías Fraunces + Karla.

## Turnos

El CTA va a WhatsApp (`wa.me/5491138475751`) con mensajes prellenados distintos
según desde dónde se toque, para saber qué parte de la página convirtió. Si más
adelante quieren un turnero (AgendaPro, Gendu, Turnito), se reemplazan los
`href` de `.cta` y del `.dock`.

## Accesibilidad

Foco visible, enlace de salto, contraste AA, `prefers-reduced-motion`
respetado en el scroll.
