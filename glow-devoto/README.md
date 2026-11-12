# Glow Devoto — landing

Estático. Sin build, sin npm. Se sube arrastrando la carpeta a Hostinger o
cualquier hosting estático. Si tocás CSS o JS, subí el `?v=20261112c` del HTML.

---

## ⚠️ FALTAN LAS FOTOS — es lo único que bloquea

Esta versión sigue el lenguaje visual de ALL.ALBA, y ese estilo **vive de la
fotografía**. Los 7 espacios están maquetados y reservados, con las medidas
puestas encima. Hoy muestran un degradado; cuando pongas las fotos, la página
pasa de «bien» a «como la referencia».

No pude bajar fotos de stock: todas las fuentes (Unsplash, Pexels, Pixabay,
Openverse, Wikimedia) están bloqueadas en este entorno.

### Las 7 fotos que hacen falta

| Dónde | Medida | Qué se ve |
|---|---|---|
| Hero | 1600×900 | El local o una toma de piel luminosa. Clara y aireada |
| Tarjeta Piernas | 600×600 | Piernas, piel suave |
| Tarjeta Cavado | 600×600 | Algo discreto: toalla, camilla, detalle del espacio |
| Tarjeta Rostro | 600×600 | Rostro, cejas |
| Tarjeta Torso | 600×600 | Hombro o brazo |
| Sala | 700×900 | Vertical. La camilla, la sala preparada |
| Banda teal | 640×400 | Retrato de quien atiende, o el equipo |

**De dónde sacarlas:** lo ideal es el Instagram del negocio. Si no, un celular
moderno con luz de ventana alcanza. Clave: luz natural, fondo limpio, tonos
claros.

**Cómo ponerlas:** guardalas en `assets/img/` y en el HTML reemplazá cada
bloque `<div class="ph ...">` por `<img src="assets/img/hero.jpg" alt="...">`.
El CSS ya tiene las proporciones.

## Qué validar con el negocio

Estos datos los propuse yo, no vienen de Glow Devoto:

| Qué | Propuesto |
|---|---|
| **Oferta** | 20% off en la primera sesión |
| **Vigencia** | Hasta fin de mes |
| **Garantía** | Si no quedás conforme, no pagás |
| **Higiene** | Espátula descartable por persona y zona, papel nuevo |
| **Horarios** | Lun a Vie 9–19, Sáb 9–14 |
| **Bajada del logo** | «cuidamos tu piel» |

Las reseñas no son testimonios inventados: la sección muestra el 4,7 y las 68
reseñas reales, con link al perfil de Google.

## Estructura

Lenguaje visual de la referencia, pero conservando el embudo:

1. Hero con foto, titular centrado, botón y puntaje
2. Banda teal con los 4 pilares e íconos de línea
3. «Nuestros 4 caminos» — tarjetas con foto y botón
4. Paso a paso del turno + foto vertical
5. Banda teal con la oferta
6. Reseñas sobre rosa empolvado
7. Primera vez (objeciones)
8. Contacto

El menú usa anclas internas, así que no saca gente del embudo. En móvil se
oculta y aparece la barra fija de abajo. **11 enlaces a WhatsApp**, cada uno
con mensaje prellenado distinto para saber qué sección convirtió.

## Paleta

Teal `#2e8585`, rosa empolvado `#faeae6`, coral `#e07a62`, gris suave
`#f2efed`. Tipografías Jost (títulos, light) + Karla (texto).
