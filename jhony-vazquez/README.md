# Jhony Vazquez — Hair & Coffee

Landing estática para la peluquería-café de San Martín 1101, Avellaneda.
Sin build, sin npm. Se arrastra la carpeta a Hostinger o similar.

---

## ⚠️ Faltan las fotos — 11 espacios

No pude bajar nada: Instagram y todas las fuentes de stock están bloqueadas en
este entorno. Cada espacio está maquetado con su medida encima.

| Dónde | Medida | Cantidad |
|---|---|---|
| Hero (fondo del salón) | 1800×1000 | 1 |
| Galería de trabajos | 900×1100 | 6 |
| El café | 800×1000 | 1 |
| Equipo (retratos) | 700×700 | 3 |

Las de galería y equipo salen directo de `@jhony_vazquezpeluqueria`. Para
montarlas: van en `assets/img/` y se reemplaza cada `<div class="ph ...">` por
un `<img>`; el CSS ya tiene las proporciones.

## Qué validar con el negocio

| Qué | Estado |
|---|---|
| **Precios** | En blanco. Se muestran como «Desde $—» |
| **Condición fiscal** | Puse «Factura A o B» porque tu nota dice que puede pedir factura |
| **Horarios** | A confirmar |
| **Nombres del equipo** | Solo «Jhony». Faltan dos y las especialidades |
| **Café incluido sin cargo** | Lo propuse yo. Es el gancho de la sección del café: hay que confirmarlo |

Las reseñas no son inventadas: muestro el 4,9 y las 444 reales con link a Google.

## Decisiones

**Identidad nueva**, porque no hay web de donde sacar colores y el Instagram no
es alcanzable desde acá.

**Espresso + crema + latón, tres colores.** Las fuentes del rubro coinciden en
que negro y dorado comunica premium — que es lo que corresponde a un alto
ticket — y que para el cruce barbería-café conviene base neutra cálida con un
solo acento. Archivo 800 para títulos, Work Sans para texto.

**Deliberadamente opuesto a Glow Devoto.** Esa es teal claro, aireada y
centrada; esta es oscura, densa y alineada a la izquierda. Dos propuestas que
no se parecen.

**El café como sección propia.** Es la mitad del nombre y lo que lo separa de
cualquier peluquería del conurbano. La sección clara además corta el oscuro
justo antes del cierre.

**Estructura según investigación del rubro:**

- Reservar domina: botón en la barra fija superior, en el hero, en servicios,
  en galería, en el cierre y en la barra inferior de móvil
- **Reseñas pegadas a los botones de reserva** — aparece en el hero, en la tira
  dorada y en el bloque final
- **Rangos de precio y nombres de pila del equipo**: un caso documentado mejoró
  la conversión al agregarlos
- Galería de trabajos propia, pedida explícitamente en la prospección
- Tap-to-call además de WhatsApp, para quien prefiere hablar

## Paleta

Espresso `#241a14`, café `#3e2b20`, crema `#f4ece0`, latón `#c8954a`.
