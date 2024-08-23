# README
## Tecnologías utilizadas
- Rvm 1.29.12
- Ruby 3.3.4
- Postgresql 16.3
- Rails 7
- Bulma CSS
- Vue 3

## Explicación básica
Implementé una aplicación monolítica que usa Rails 7 y un poco de Vue 3 para las vistas.

Investigué si había algún algoritmo conocido para resolver el problema de manera eficiente y encontré estas opciones (entre otras):
1. Programación por restricciones
2. Programación Lineal
3. Algoritmos evolutivos
Como no tenía experiencia con estas técnicas me puse a investigar un poco sobre cada uno e intenté implementar programación 
por restricciones pero no pude llegar a nada por la falta de experiencia y tiempo.

Entonces, mirando el mockup del ejemplo noté que se listaba el total de horas por cada empleado y parecían bastante equilibrados,
de ahí se me ocurrió la idea de combinar todas las soluciones posibles para luego sumar las horas por empleado para cada solución,
Luego aplico un algoritmo para determinar cual solución es la más equilibrada y elijo esa. Si bien, realicé muchas iteraciones, lo
cual no me gustó mucho, al final la implementación parece ser bastante rápida.

## Proceso en general:

**Paso 1: Identifico todos los turnos posibles**
- El lunes lo cubre sólo Ernesto lo que me dá un turno posible: [turno_1_lunes_ernesto]
- El martes lo cubren totalmente todos los empleados lo que me da 3 turnos posibles: [turno_1_martes_ernesto, turno_2_martes_barbara, turno_3_martes_benjamin]
- El Sabado lo cubren paracialmente todos los empleados, lo cual me dió 2 turnos posibles: [turno_1_sabado_ernesto_barbara_benjamin, turno_2_sabado_ernesto_benjamin]

El tema de identificar los turnos posibles para los turnos parciales del sábado fue un dolor de cabeza, si bien parecía sencillo distribuir mentalmente, al momento
de implementarlo me costó mucho, la parte del algoritmo que hace eso fue a mucha prueba y error.

**Paso 2: Realizo la combinacion de todos los turnos posibles**
Para esto usé el método product de array. Obtengo algo asi:
Solucion 1: [turno_1_lunes_ernesto, turno_1_martes_ernesto, turno_1_sabado_ernesto_barbara_benjamin]
Solucion 2: [turno_1_lunes_ernesto, turno_2_martes_barbara, turno_1_sabado_ernesto_barbara_benjamin]
Solucion 3: [turno_1_lunes_ernesto, turno_3_martes_benjamin, turno_1_sabado_ernesto_barbara_benjamin]

**Paso 3: Recorro cada solucion e identifico el total de horas asignada a cada empleado**
**Paso 4: Hago que un algoritmo analice cada conjunto de horas de cada solucion y busca el conjunto de horas mas equilibrado, ademas el conjunto
debe cubrir la mayor cantidad de horas posible del cliente que requiere el monitoro. Este algorimo me devuelve la solución más optima**

## Partes
- Tengo los modelos principales que son week_schedule y sus hijos client_week_schedule y employee_week_schedule para modelar las horas del cliente y las disponibilidades del empleado.
- El modelo day_schedule comforma los detalles de week_schedule y guarda el rango de horas para cada día.
- El servicio monitoring_schedule maneja toda la lógica para identificar la solución más óptima

## Observaciones
- Creo que logré un algoritmo que realiza lo que se pidió, si bien con los datos dados en el mockup se genera una solución un poquito diferente para la asignación del sábado, 
el algoritmo a mi parecer genera una asignación de horas más equilibrada entre los empleados
- Me consumió bastante tiempo lograr este algoritmo, por lo que no me dió tiempo de implementar totalmente el frontend, aún así implementé unas vistas rudimentarias
para comprobar el algoritmo con los datos de ejemplo dados en la prueba. Además que mi implementación de frontend no demuestra lo mejor de mi.

## Pasos de Instalación
```sh
bundle install
rake db:create
rake db:migrate
rake db:seed
rails s
```
