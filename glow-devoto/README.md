# Glow Devoto — landing

Sitio estático. Sin build, sin npm. Se sube arrastrando la carpeta a Hostinger,
Netlify o cualquier hosting estático.

```
index.html   styles.css   main.js   .htaccess
```

El `.htaccess` evita que Hostinger sirva CSS/JS viejo después de cada deploy.
Si editás `styles.css` o `main.js`, subí el `?v=20261112` de `index.html` a la
fecha del día.

---

## ⚠️ ANTES DE MOSTRARLA AL NEGOCIO

Escribí afirmaciones concretas sobre **cómo trabajan** que inventé a partir de
buenas prácticas del rubro, no de información real de Glow Devoto. Hay que
confirmarlas o cambiarlas con ellas antes de publicar:

- «Espátula descartable, una por persona y por zona. La cera usada no vuelve al pote.»
- «Camilla con papel nuevo en cada turno.»
- «Se cobra lo que se hizo, no el turno completo.»
- «Te lo mandamos por WhatsApp» (las indicaciones post-depilación).
- «Puerta cerrada, te preparás a tu ritmo.»

Si alguna no es así, se corrige el texto. Publicarlas sin confirmar sería
prometer algo en nombre de ellas.

## Marcado como pendiente

Lo que quedó sin dato real está subrayado con línea punteada ámbar
(`[data-editar]` en el HTML):

| Dónde | Qué falta |
|---|---|
| Sección «Dónde y cuándo» | **Horarios de atención** |
| Footer | **Link de Instagram** |

## Datos que sí vienen de la prospección

Dirección, teléfono, 4,7 / 68 reseñas, pago por transferencia. Conviene
verificarlos igual contra el perfil de Google del negocio.

## Duraciones y precios

Las duraciones por zona son estimaciones estándar del rubro: confirmalas.

Los precios **no están en la página a propósito**. Con la inflación argentina,
una lista desactualizada hace más daño que no tenerla; la página deriva a
WhatsApp para el precio del día. Si el negocio prefiere mostrarlos, se agrega
una columna en `.svc__list`.

## Turnos

El CTA va a WhatsApp (`wa.me/5491138475751`) con mensaje prellenado. Es como
reserva realmente un salón chico en Argentina. Si más adelante quieren un
turnero (AgendaPro, Gendu, Turnito), se reemplaza el `href` de los botones
`.btn--solid` y listo.

---

## Decisiones de diseño

**Archetype: Editorial Dark Warm.** Los sitios de belleza casi nunca usan fondo
oscuro, porque compite con la fotografía. Acá no hay fotos — así que el fondo
oscuro deja de ser un problema y pasa a ser la oportunidad: diferencia en la
categoría y le da al nombre («Glow») el fondo que necesita para brillar.

**Paleta:** marrón-negro cálido `#17100d`, acento miel `#e9a23b` (la cera),
contrapunto salvia `#7e9689`. Evita a propósito los dos clichés: el rosa de
salón de belleza y el crema-con-terracota que delata una página generada por IA.

**Tipografía:** Instrument Serif + Karla. Nada de Playfair/Lato.

**Un solo efecto protagonista:** el resplandor que sigue al cursor. Todo lo
demás es quieto. Sin fade-up en cada sección, sin tarjetas iguales con la misma
sombra, sin flechas en los botones.

**El contenido es el diferencial.** La sección «Primera vez» responde lo que la
investigación del rubro marca como la barrera real para reservar: miedo a ser
juzgada por el cuerpo, dolor, privacidad y control. Casi ningún sitio del rubro
lidera con eso.

## Accesibilidad

Contraste del texto secundario 5,3:1 (AA). Foco visible. Enlace de salto.
`prefers-reduced-motion` desactiva solo el resplandor animado, no las
microinteracciones: Windows lo trae activado de fábrica y la página se vería
muerta.

## Si no hay JavaScript

El título, los textos y los botones funcionan igual. El `<html class="no-js">`
se remueve al cargar `main.js`; el CSS tiene las reglas de respaldo.
