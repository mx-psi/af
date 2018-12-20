# Propiedades

## Teorema de convolución

:::{.theorem}
Dadas dos secuencias $\{x\} = x_1, \dots, x_N$, $\{y\} = y_1, \dots, y_N$ de $N$ números complejos se verifica
$$\mathcal{F}(\{x\} \ast \{y\}) = \frac{1}{N} \mathcal{F}\{x\} \mathcal{F}\{y\}.$$
:::

## Teorema de Parseval y corolarios (1)

:::{.theorem name="Teorema de Parseval"}
Se verifica
$$\langle \{x\}, \{y\}\rangle = \frac{1}{N} \langle \{X\}, \{Y\}\rangle.$$
:::

## Teorema de Parseval y corolarios (2)

:::{.corollary name="Teorema de Plancherel"}
Se verifica
$$\|\{x\}\|_2 = \frac{1}{\sqrt{N}} \|\{X\}\|_2.$$
:::

:::{.corollary #cor:isometries}
$\operatorname{UDT}$ y $\operatorname{UDT}^{-1}$ definen isometrías.
:::

## Teorema de desplazamiento

Para las siguiente propiedad veremos las secuencias $\{x\}$ y $\{X\}$ como $N$-periódica, esto es, $x_{k+N}:=x_k$ y $X_{k+N}:=X_k$ para todo $k$.

:::{.theorem name="Teorema de desplazamiento"}
Definiendo $\operatorname{shift}_h\{x\}:=x_h, x_{h+1}, \dots, x_{h+N-1}$, se verifica
$$\mathcal{F}(\operatorname{shift}_h\{x\})=\{X\} \{W_N^{-hk}\}_{0 \leq k < N}$$
y
$$\mathcal{F}(\{x\} \{W_N^{-hk}\}) = \operatorname{shift}_{-h}\{X\}.$$
:::
