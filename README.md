[![build](https://github.com/matmirr/meeseeksObjetosos/actions/workflows/ci.yml/badge.svg)](https://github.com/matmirr/meeseeksObjetosos/actions/workflows/ci.yml)

# Meeseeks destructores — versión Objetos

> Adaptación del Tema 1 del parcial funcional 2026 para la clase de Elementos de Diseño (M15) e introducción a Strategy. Se omiten el punto 2 y el 4b del original; se conserva la numeración.

*"I'm Mr. Meeseeks! Look at me!"*

Rick le regaló a la familia Smith una Caja de Meeseeks: un dispositivo que, al apretar el botón, hace aparecer un Mr. Meeseeks con la tarea que se le pida. Los Meeseeks existen para servir: aparecen, cumplen su tarea y desaparecen. Si la tarea se demora, sufren cada vez más, se vuelven más oscuros y peligrosos.

De cada Meeseeks conocemos:

- su nombre (siempre arranca con `"Mr. Meeseeks"`, pero puede recibir sufijos),
- el color, que va del más claro al más oscuro: `"celeste"`, `"azul"`, `"violeta"`, `"negro"`,
- las horas de existencia que lleva activo (un número),
- la tarea actual que está intentando cumplir (por ejemplo, `"sacar dos golpes al golf"`),
- el historial de intentos: una colección de intentos, donde cada intento tiene una descripción de la tarea y la cantidad de horas que le tomó.

Una caja es un conjunto de Meeseeks.

## Punto 1: I'm Mr. Meeseeks!

### a) Modelar los Meeseeks

Según lo indicado en la introducción. Adicionalmente, se pide modelar un Meeseeks de ejemplo.

### b) Color que merece

Queremos saber el color que le corresponde a un Meeseeks según sus horas de existencia:

- Si lleva menos de 1 hora y su nombre tiene longitud par, le corresponde `"celeste"`.
- Si lleva entre 1 y 5 horas (inclusive), le corresponde `"azul"`.
- Si lleva más de 5 y hasta 24 horas, le corresponde `"violeta"`.
- En cualquier otro caso, le corresponde `"negro"` (entró en pánico existencial).

### c) ¿Está sufriendo?

Queremos saber si un Meeseeks está sufriendo, lo cual ocurre si su color actual no coincide con el color que le correspondería según sus horas de existencia, o si su tarea actual contiene la palabra `"golf"` (los Meeseeks odian el golf). Se busca exactamente la palabra `"golf"` en minúscula.

## Punto 3: Can do!

En este punto no debe repetir lógica.

Existen distintas interacciones que la familia puede tener con un Meeseeks. Cada interacción transforma al Meeseeks de alguna manera:

- **Pedir ayuda:** le suma 1 hora de existencia y le cambia la tarea actual por la nueva tarea pedida.
- **Golpear:** enloquece al Meeseeks. Le agrega el sufijo `" (enojado)"` al nombre y duplica sus horas de existencia. Si no tenía horas (recién salió de la caja), lo deja con 1 hora para que sienta algo.
- **Agradecer:** le permite completar su tarea. Agrega al historial un intento con la tarea actual y las horas de existencia que llevaba, reinicia las horas de existencia en 0 y la tarea actual en `"ninguna"`.
- **Frustrarse:** como hacen los Meeseeks cuando otro Meeseeks no puede ayudarlos. Hace lo mismo que golpear, pero el doble de veces.

Indicar cómo se haría en la consola para que un Meeseeks reciba la siguiente secuencia de interacciones: que le pidan ayuda con la tarea `"abrir un frasco"`, que sea golpeado, que se frustre y que finalmente le agradezcan. No importa el resultado, sino cómo es la invocación en la consola.

## Punto 4: Existence is pain!

La familia descubrió que apretando el botón de la caja una y otra vez puede llevar a todos los Meeseeks al colapso.

Cada caja tiene configurada la secuencia de castigos que aplica su botón: interacciones del punto 3, que la familia puede cambiar en cualquier momento. Apretar el botón significa aplicarle a cada Meeseeks de la caja esa secuencia de castigos, en orden: la primera se aplica primero. Por ejemplo, con *[pedir ayuda con "limpiar el sótano", golpear, frustrarse]*, a cada Meeseeks primero se le pide ayuda, después se lo golpea y después se frustra.

Además, cada caja tiene su propia idea de cuándo está colapsada. Algunas cajas se consideran colapsadas cuando todos sus Meeseeks están sufriendo (es lo habitual); otras, cuando sufre más de la mitad; y las más sensibles, con que uno solo sufra. La familia puede cambiar ese criterio en cualquier momento.

### Hasta colapsar

Queremos que la caja apriete su botón repetidamente hasta que esté colapsada. El botón se aprieta al menos una vez: se aplican los castigos a toda la caja y, si todavía no está colapsada, se vuelve a apretar, y así hasta que colapse.

> **Ojo:** acá hay dos cosas distintas. Por un lado, aplicarle a cada Meeseeks los castigos de la secuencia, uno tras otro. Por otro, repetir el botoneo sobre la caja hasta que colapse. Pensá cuál de las dos necesita recursividad.
