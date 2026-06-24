1. Estructura Global del Programa
● Punto de Entrada: Todo programa comienza obligatoriamente con la palabra clave
program, seguida de un identificador (el nombre del programa) y un bloque delimitado por
llaves { ... }.
● Secuencial: Dentro del bloque principal se ejecutan una serie de sentencias (sentence)
en orden secuencial.
● Entorno de Ejecución: El programa cuenta con una tabla de símbolos global
(symbolTable) para almacenar y recuperar el valor de las variables durante la ejecución.
2. Tipos de Datos Soportados (Literales)
El lenguaje es capaz de reconocer y operar dinámicamente con los siguientes tipos de datos
básicos primitivos:
● Enteros (INT): Secuencias numéricas estándar (ej. 10, 42).
● Decimales (FLOAT): Números con punto flotante (ej. 3.14, 0.5).
● Cadenas de Texto (STRING): Texto delimitado entre comillas dobles (ej. "Hola Mundo").
La gramática remueve automáticamente las comillas al procesar el nodo.
● Booleanos (BOOLEAN): Representados explícitamente por las palabras clave true o
false.
3. Manejo de Variables
● Declaración y Asignación: Admite dos formas para la creación y actualización de
variables:
1. Declaración con asignación opcional: Se usa la palabra clave var seguida del
identificador. Permite inicializarse inmediatamente o quedarse solo declarada (ej.
var x = 5; o var x;).
2. Asignación pura: Modifica el valor de una variable ya existente usando el
operador = (ej. x = 10;).
● Referenciación: Se pueden invocar las variables en cualquier expresión matemática o
lógica llamándolas por su identificador (ID).
4. Expresiones y Precedencia de Operadores
El lenguaje cuenta con una robusta jerarquía de operaciones, organizada de menor a mayor
prioridad, evitando ambigüedades en el parseo:
1. Disyunción Lógica: Operador || (OR).
2. Conjunción Lógica: Operador && (AND).
3. Comparaciones Relacionales: Operadores de igualdad y orden: >, <, >=, <=, ==, !=.
4. Operaciones Aritméticas Básicas: * Suma (+) y Resta (-).
○ Multiplicación (*) y División (/).
5. Operadores Unarios y Agrupación: * Negación lógica ! (NOT), que se aplica directamente a términos.
○ Paréntesis ( ) para forzar o alterar cualquier orden de prioridad.
5. Estructuras de Control y Salida
● Flujo Condicional (if-else): Estructura bifurcada obligatoria. Evalúa una expresión
booleana entre paréntesis y ejecuta el primer bloque si es verdadera, o el bloque else si
es falsa.
● Bucle Condicional (while): Estructura de repetición iterativa. Evalúa una condición y
ejecuta cíclicamente su bloque interno mientras la condición continúe siendo verdadera.
● Salida de Datos (println): Permite imprimir en la consola el resultado evaluado de
cualquier expresión válida (cadenas, números o resultados lógicos) seguido de un salto
de línea.
6. Sintaxis General y Comentarios
● Fin de Sentencia: Todas las declaraciones, asignaciones e instrucciones de salida
finalizan obligatoriamente con un punto y coma (;).
● Comentarios: Soporta dos estilos de documentación que el intérprete ignora por
completo:
○ Línea única usando //.
○ Múltiples líneas delimitadas por /* ... */.