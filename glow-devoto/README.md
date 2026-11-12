# Glow Devoto — landing con embudo de ventas

Sitio estático. Sin build, sin npm. Se sube arrastrando la carpeta a Hostinger,
Netlify o cualquier hosting estático.

```
index.html   styles.css   main.js   .htaccess
```

Si editás CSS o JS, subí el `?v=20261112b` de `index.html`.

---

## ⚠️ Qué hay que validar con el negocio

Ya no quedan huecos: la página está completa y se puede mostrar. Pero estos
datos los propuse yo, no vienen de Glow Devoto. Antes de ponerla online hay que
confirmarlos:

| Qué | Propuesto | Nota |
|---|---|---|
| **Oferta** | 20% off en la primera sesión | Es el motor del embudo. Si el número cambia, se toca en dos lugares del HTML |
| **Vigencia** | Hasta fin de mes | Elegida porque es fácil de sostener y no es escasez falsa |
| **Garantía** | Si no quedás conforme, no pagás | Es una promesa comercial: tienen que querer sostenerla |
| **Higiene** | Espátula descartable por persona y zona, sin volver al pote, papel nuevo | Es el estándar del rubro, pero hay que confirmar que trabajan así |
| **Horarios** | Lun a Vie 9–19, Sáb 9–14 | Horario típico de la zona |

### Las reseñas

No puse testimonios. Inventar reseñas con nombres falsos sería fabricar prueba
social, y además es lo primero que un cliente detecta. En su lugar la sección
muestra el 4,7 real, las 68 reseñas reales y un link al perfil de Google.

Si querés testimonios en la página, se copian tres reales del perfil con nombre
y mes. El bloque se arma en diez minutos.

### El Instagram

Saqué el link del footer en vez de inventar un usuario. Cuando tengas el handle
real, se agrega.

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
