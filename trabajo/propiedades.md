# Propiedades

En esta sección consideraremos las secuencias $\{x\} = x_1, \dots, x_n, \{y\} = y_1, \dots, y_n \in \mathbb{C}^N$ y sus respectivas DFT $\{X\} = X_1, \dots, X_n := \mathcal{F}\{x\}, \{Y\} = Y_1, \dots, Y_n := \mathcal{F}\{y\}$.

Enunciamos a continuación algunas propiedades elementales sobre la DFT.

## Teorema de convolución

El siguiente Teorema establece una relación fundamental entre la convolución de secuencias y la DFT:  la DFT de la convolución de secuencias es el producto de sus respectivas DFT.

:::{.theorem #thm:conv}
Dadas dos secuencias $\{x\} = x_1, \dots, x_N$, $\{y\} = y_1, \dots, y_N$ de $N$ números complejos se verifica
$$\mathcal{F}(\{x\} \ast \{y\}) = \frac{1}{N} \mathcal{F}\{x\} \mathcal{F}\{y\}.$$
:::

:::{.proof}
Llamando $\{z\} = \{x\} \ast \{y\} = z_0, \dots, z_{N-1}$, $\{Z\} = \mathcal{F}\{z\} = Z_0, \dots, Z_{N-1}$, $\{X\} = \mathcal{F} \{x\} = X_0, \dots, X_{N-1}$, $\{Y\} = \mathcal{F} \{y\} = Y_0, \dots, Y_{N-1}$, se tiene

$$\begin{split}
Z_k & = \sum_{n=0}^{N-1} z_n W_N^{kn} = \sum_{n=0}^{N-1} \left( \frac{1}{N} \sum_{m=0}^{N-1} x_m y_{n-m} \right) W_N^{kn} = \frac{1}{N} \sum_{m=0}^{N-1} \left( \sum_{n=0}^{N-1} x_m y_{n-m} W_N^{kn} \right) \\
& = \frac{1}{N} \sum_{m=0}^{N-1} \left( x_m W_N^{km} \sum_{n=0}^{N-1} y_{n-m} W_N^{k(n-m)} \right) = \frac{1}{N} \sum_{m=0}^{N-1} \left( x_m W_N^{km} \sum_{n=0}^{N-1} y_n W_N^{kn} \right) \\
& \frac{1}{N} \left( \sum_{m=0}^{N-1} x_m W_N^{km} \right) \left( \sum_{n=0}^{N-1} y_n W_N^{kn} \right) = X_k Y_k,\\
\end{split}$$

donde $x_{k \pm N} := x_k, y_{k \pm N} := y_k$, lo que concluye la prueba.
:::

## Teorema de Parseval y corolarios

:::{.proposition #prop:conjugacion}
Para $N$ par, si $\{x\}$ es una secuencia real, se tiene $X_{\frac{N}{2}+k} = X_{\frac{N}{2}-k}^{\ast}$ para cada $k$, considerando $x_k = x_{k+N}$.
:::
:::{.proof}
Basta ver que
$$\begin{split}
X_{\frac{N}{2}+k} & = \sum_{n=0}^{N-1} x_n W_N^{\left(\frac{N}{2}+k\right)n} = \sum_{n=0}^{N-1} -x_n W_N^{kn} = \sum_{n=0}^{N-1} \left(-x_n W_N^{kn}\right)^{\ast} \\
& = \sum_{n=0}^{N-1} \left(x_n W_N^{\left(\frac{N}{2}-k\right)n}\right)^{\ast} = X_{\frac{N}{2}-k}^{\ast},
\end{split}$$
para cualquier $k$, donde hemos usado $W_N^{\frac{N}{2}}=-1$ y $W_N^{\ast} = W_N^{-1}$.
:::

:::{.theorem #thm:parseval name="Teorema de Parseval"}
Se verifica
$$\langle \{x\}, \{y\}\rangle = \frac{1}{N} \langle \{X\}, \{Y\}\rangle.$$
:::

:::{.proof}
$$\begin{split}
\langle \{x\}, \{y\} \rangle & = \left(\{x\}^{\ast}\right)^T \{y\} = \left( \left( \frac{1}{N}G\{X\} \right)^{\ast} \right)^T \left( \frac{1}{N} G\{Y\}\right) = \frac{1}{N^2} \left( \{X\}^{\ast} \right)^T \left(G^{\ast}\right)^T G\{Y\} \\
& = \frac{1}{N^2} \left( \{X\}^{\ast} \right)^T FG\{Y\} = \frac{1}{N} \left( \{X\}^{\ast} \right)^T \{Y\} = \frac{1}{N} \langle \{X\}, \{Y\}\rangle\end{split}$$
:::

:::{.corollary #cor:plancherel name="Teorema de Plancherel"}
Se verifica
$$\|\{x\}\|_2 = \frac{1}{\sqrt{N}} \|\{X\}\|_2.$$
:::

:::{.proof}
Basta ver que $\|\{x\}\|_2^2 = \frac{1}{N} \langle \{x\}, \{x\}^{\ast} \rangle = \langle \{X\}, \{X\}^{\ast} \rangle = \frac{1}{N} \|\{X\}\|_2^2$.
:::

:::{.corollary #cor:isometries}
$\operatorname{UDT}$ y $\operatorname{UDT}^{-1}$ definen isometrías.
:::

## Teorema de desplazamiento

Para las siguientes propiedades veremos las secuencias $\{x\}$ y $\{X\}$ como $N$-periódica, esto es, $x_{k+N}:=x_k$ y $X_{k+N}:=X_k$ para todo $k$.

:::{.proposition #prop:despcircular name="Teorema de desplazamiento"}
Definiendo $\operatorname{shift}_h\{x\}:=x_h, x_{h+1}, \dots, x_{h+N-1}$, se verifica
$$\mathcal{F}(\operatorname{shift}_h\{x\})=\{X\} \{W_N^{-hk}\}_{0 \leq k < N}$$
y
$$\mathcal{F}(\{x\} \{W_N^{-hk}\}) = \operatorname{shift}_{-h}\{X\}.$$
:::
:::{.proof}
Sea $\hat{X}_0, \dots, \hat{X}_{N-1} := \mathcal{F}(\operatorname{shift}_h\{x\})$. Se tiene
$$\hat{X}_k = \sum_{n=0}^{N-1} x_{h+n} W_N^{kn} = \sum_{n=h}^{h+N-1} x_n W_N^{k(n-h)} =  \left(\sum_{n=h}^{h+N-1} x_n W_N^{kn}\right) W_N^{-hk} = X_k W_N^{-hk}$$
para $0 \leq k < N$.

Por otro lado,
$$X_{k-h} = \sum_{n=0}^{N-1} x_n W_N^{k(n-h)} = \sum_{n=0}^{N-1} \left( x_n W_N^{-hk} \right) W_N^{kn}.$$
:::
