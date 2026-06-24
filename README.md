# Trabajo Práctico ANTLR

## Integrantes:
- González, Lautaro DNI
- Savall, Arián DNI 46686015

## Estructura implementada: while

---

---


Este documento contiene la descripción formal, características sintácticas y capacidades del lenguaje de programación **Simple**, basado en la especificación de su gramática desarrollada en ANTLR4.

---

## 1. Estructura Global del Programa

Todo programa escrito en **Simple** sigue un esquema rígido y bien definido estructurado como un bloque principal único.

* **Punto de Entrada:** El programa debe comenzar obligatoriamente con la palabra clave `program`, seguida de un identificador alfanumérico que actúa como el nombre del programa (por ejemplo, `program miprograma`).
* **Bloque de Ejecución:** Todo el código ejecutable debe estar contenido dentro de un par de llaves principales `{ ... }`.
* **Secuencialidad:** Las instrucciones o sentencias (`sentence`) dentro del bloque se ejecutan de manera secuencial, de arriba hacia abajo.
* **Tabla de Símbolos:** Durante la ejecución, el intérprete inicializa y mantiene un mapa/diccionario (`symbolTable`) que sirve como memoria global para almacenar, recuperar y actualizar el valor de las variables.

---

## 2. Tipos de Datos Soportados (Literales)

El lenguaje admite de forma nativa cuatro tipos de datos primitivos esenciales para el cómputo y la manipulación de información:

| Tipo de Dato        | Token ANTLR | Descripción | Ejemplos |
|:--------------------| :--- | :--- | :--- |
| **Entero**          | `INT` | Secuencias numéricas enteras (positivas o negativas). | `10`, `42`, `0` |
| **Real**            | `FLOAT` | Números en punto flotante separados obligatoriamente por un punto. | `3.14`, `0.5`, `99.9` |
| **Cadena de Texto** | `STRING` | Cualquier secuencia de caracteres encerrada entre comillas dobles. | `"Hola Mundo"`, `"UNLa"` |
| **Booleano**        | `BOOLEAN` | Valores lógicos de la álgebra de Boole. | `true`, `false` |

*Nota: Durante la fase de análisis semántico/construcción del AST, la gramática elimina automáticamente las comillas dobles extremas de los `STRING` mediante un sub-string en Java.*

---

## 3. Sistema de Variables y Asignación

El lenguaje implementa un sistema dinámico de gestión de variables mediante dos instrucciones específicas:

### A. Declaración con Asignación Opcional (`var_decl`)
Utiliza la palabra clave reservada `var`. Permite crear una variable dentro de la tabla de símbolos. Puede inicializarse inmediatamente con el resultado de una expresión o posponer su valor:
```
var x = 5;      // Declaración e inicialización inmediata
var cadena;     // Declaración pura (valor inicial es igual a 0)
```

### B. Asignación Pura (`var_assign`)

Permite redefinir o actualizar el valor de una variable que ya ha sido declarada previamente en el entorno de ejecución, utilizando el operador =:
```
x = 10;
cadena = "Nuevo texto";
```

## 4. Jerarquía y Precedencia de Operadores

Para evitar cualquier tipo de ambigüedad durante el parsing (como el clásico dilema de si la suma se evalúa antes que la multiplicación), la gramática establece una estructura en cascada que define estrictamente la prioridad de los operadores de menor a mayor relevancia:

1. **Disyunción Lógica (`||`):** Operador OR binario (`logical_or_expr`).

2. **Conjunción Lógica (`&&`):** Operador AND binario (`logical_and_expr`).

3. **Comparadores Relacionales:** Operadores de comparación de orden e igualdad (`comparation`):

   - Mayor que (`>`), Menor que (`<`)

   - Mayor o igual que (`>=`), Menor o igual que (`<=`)

   - Igualdad (`==`), Distinto o negación de igualdad (`!=`)

4. **Operaciones Aritméticas de Adición:** Suma (`+`) y Resta (`-`) (`arithmetic_expr`).
5. **Operaciones Aritméticas de Factor:** Multiplicación (`*`) y División (`/`) (`factor`).
6. **Operador Unario de Negación (`!`):** El operador lógico NOT (`term`) posee la máxima prioridad y se aplica directamente a expresiones atómicas, permitiendo su encadenamiento (ej. `!!true`).
7. **Agrupación Lineal:** El uso de paréntesis `( )` interrumpe la precedencia natural, forzando la evaluación interna en primer lugar.

## 5. Estructuras de Control de Flujo y Salida

Simple cuenta con capacidades de bifurcación y repetición condicional estructurada, además de un mecanismo de salida estándar:

### Entrada/Salida Estándar (`println`)

Muestra el resultado evaluado de cualquier expresión aritmética, lógica o literal en la consola del sistema, seguido de un salto de línea automático. Cada instrucción debe finalizar con un punto y coma `;`.

```
println "El resultado es: ";
println (5 + 3) * 2;
```

### Estructura Condicional Doble (`if-else`)

Evalúa una condición encerrada entre paréntesis. Si la condición se evalúa como `true`, se ejecuta secuencialmente el primer bloque de llaves. En caso de evaluarse como `false`, es obligatorio derivar el flujo de ejecución hacia el bloque definido bajo la palabra clave `else`.
```
if (x > 5) {
println "Es mayor";
} else {
println "Es menor o igual";
}
```
### Bucle Iterativo Condicional (`while`)

Permite repetir cíclicamente un bloque de código. Mientras la expresión condicional definida entre paréntesis se evalúe como verdadera (`true`), las sentencias internas se ejecutarán de forma iterativa.
```
while (x < 10) {
println x;
x = x + 1;
}
```

## 6. Reglas Sintácticas Generales
* Terminación de Sentencias: Toda instrucción de asignación, declaración o impresión en consola exige de forma mandatoria la presencia de un punto y coma (`;`) al final de la línea. Las estructuras de control (`if`, `while`) no lo requieren tras sus llaves de cierre.
* Comentarios: El compilador ignora por completo los comentarios para facilitar la documentación interna del código fuente:
  * Línea única: Declarados con `//`.
  * Multilínea o de bloque: Delimitados entre `/*` y `*/`.