# Transformada cuántica de Fourier

## Principios de mecánica cuántica

1. El espacio de estados de un sistema cuántico está formado por los *rayos* de un espacio de Hilbert separable complejo
2. TODO
3. TODO
4. TODO

---

Otra diapositiva de ejemplo para que se vea cómo funciona.


## Composición de operaciones unitarias

:::{.definition #dfn:controlled}

1. Dados $A_i : H_i \to H'_i$ lineales ($i = 1,2$) existe una única $A_1 \otimes A_2 : H_1 \otimes H_2 \to H'_1 \otimes H'_2$ tal que
$$(A_1 \otimes A_2)(\ket{x} \otimes \ket{y}) = (A_1\ket{x}) \otimes (A_2\ket{y}),$$
conocida como su *producto tensorial*.
Si $A_1$y $A_2$ son unitarias también lo será $A_1 \otimes A_2$.
2. Si $A$ es unitaria la operación $A$*-controlada* viene dada por
$$C_A= \left(\begin{array}{c|c} I_2 & 0 \\ \hline 0 & A \end{array} \right), \quad C_A\ket{0}\ket{x} = \ket{0}\ket{x}, \quad C_A\ket{1}\ket{x} = \ket{1}A\ket{x}$$
:::
