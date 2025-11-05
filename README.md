# Lenguajes de Programación 

## 💻 Proyecto MiniLisp: Creación de un intérprete para Minilisp

---

### **Objetivo del Proyecto**

Este repositorio contiene la implementación del proyecto **MiniLisp**, un intérprete simplificado del lenguaje de programación **Lisp**, desarrollado como parte de un curso **lenguajes de programación**.

---

### **🚀 Instrucciones de Ejecución**

Sigue estos pasos para ejecutar y comenzar a interactuar con MiniLisp en tu terminal:

1.  Asegúrate de tener instalado el entorno **GHCi (Glasgow Haskell Compiler, Interactivo)** en tu sistema.
2.  **Carga el archivo del intérprete:**
    ```bash
    ghci It_Minilisp.hs
    ```
    *(Esto iniciará el entorno interactivo de Haskell y cargará el módulo de MiniLisp.)*
3.  **Inicia el intérprete de MiniLisp:**
    Una vez que veas el *prompt* de GHCi, ejecuta el siguiente comando:
    ```bash
    run
    ```

> 💡 **¡Ya estás dentro!** Con el comando `run` se inicia el *loop* de lectura y evaluación de MiniLisp. **¡Disfruta programando!**

---

### **📚 Lenguajes Utilizados**

* **Haskell** (El proyecto está escrito en Haskell, utilizando su entorno interactivo GHCi para la ejecución).
* **Alex**  (Se encarga de generar la secuancia de Tokens dado el flujo de entrada )
* **Happy**  (Recibe los Token y genera ASAs (Árbol de sintaxis abstracta) )
