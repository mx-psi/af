# Propiedades

En esta sección consideraremos las secuencias $\{x\} = x_1, \dots, x_n, \{y\} = y_1, \dots, y_n \in \mathbb{C}^N$ y sus respectivas DFT $\{X\} = X_1, \dots, X_n := \mathcal{F}\{x\}, \{Y\} = Y_1, \dots, Y_n := \mathcal{F}\{y\}$.

Enunciamos a continuación algunas propiedades elementales sobre la DFT.

:::{.proposition #prop:conjugacion}
Para $N$ par, si $\{x\}$ es una secuencia real, se tiene $X_{\frac{N}{2}+k} = X_{\frac{N}{2}-k}^{\ast}$ para cada $k$, considerando $x_k = x_{k+N}$.
:::
:::{.proof}
Basta ver que
$$\begin{split}
X_{\frac{N}{2}+k} & = \sum_{n=0}^{N-1} x_n W_N^{\left(\frac{N}{2}+k\right)n} = \sum_{n=0}^{N-1} -x_n W_N^{kn} = \sum_{n=0}^{N-1} \left(-x_n W_N^{kn}\right)^{\ast} \\
& = \sum_{n=0}^{N-1} \left(x_n W_N^{\left(\frac{N}{2}-k\right)n}\right)^{\ast} = X_{\frac{N}{2}-k}^{\ast} \text{,}
\end{split}$$
para cualquier $k$, donde hemos usado $W_N^{\frac{N}{2}}=-1$ y $W_N^{\ast} = W_N^{-1}$.
:::

:::{.theorem #thm:parseval name="Teorema de Parseval"}
Se verifica
$$\langle \{x\}, \{y\}\rangle = \frac{1}{N} \langle \{X\}, \{Y\}\rangle \text{.}$$
:::

:::{.proof}
$$\begin{split}
\langle \{x\}, \{y\} \rangle & = \sum_{k=0}^{N-1} x_k^{\ast} y_k = \sum_{k=0}^{N-1} x_k^{\ast} \left( \frac{1}{N} \sum_{n=0}^{N-1} Y_n W_N^{-nk} \right) = \frac{1}{N} \sum_{n=0}^{N-1} Y_n \left( \sum_{k=0}^{N-1} x_k^{\ast}  W_N^{-nk} \right) \\
& = \frac{1}{N} \sum_{n=0}^{N-1} Y_n \left( \sum_{k=0}^{N-1} x_k W_N^{nk} \right)^{\ast} = \frac{1}{N} \sum_{n=0}^{N-1} X_n{^\ast} Y_n = \frac{1}{N} \langle \{X\}, \{Y\}\rangle
\end{split}$$
:::

:::{.corollary #cor:plancherel name="Teorema de Plancherel"}
Se verifica
$$\|\{x\}\|_2 = \frac{1}{N} \|\{X\}\|_2 \text{.}$$
:::

:::{.proof}
Basta ver que $\|\{x\}\|_2^2 = \frac{1}{N} \langle \{x\}, \{x\}^{\ast} \rangle = \langle \{X\}, \{X\}^{\ast} \rangle = \frac{1}{N} \|\{X\}\|_2^2$.
:::

:::{.corollary}
$\operatorname{UDT}$ y $\operatorname{UDT}^{-1}$ definen isometrías.
:::

Para las siguientes propiedades veremos las secuencias $\{x\}$ y $\{X\}$ como $N$-periódica, esto es, $x_{k+N}:=x_k$ y $X_{k+N}:=X_k$ para todo $k$.

:::{.proposition #prop:despcircular name="Teorema de desplazamiento"}
Definiendo $\operatorname{shift}_h\{x\}:=x_h, x_{h+1}, \dots, x_{h+N-1}$, se verifica

$$\mathcal{F}(\operatorname{shift}_h\{x\})=\{X\} \{W_N^{-hk}\}_{0 \leq k < N}$$

y

$$\mathcal{F}(\{x\} \{W_N^{-hk}\}) = \operatorname{shift}_{-h}\{X\} \text{.}$$
:::
:::{.proof}
Sea $\hat{X}_0, \dots, \hat{X}_{N-1} := \mathcal{F}(\operatorname{shift}_h\{x\})$. Se tiene

$$\hat{X}_k = \sum_{n=0}^{N-1} x_{h+n} W_N^{kn} = \sum_{n=h}^{h+N-1} x_n W_N^{k(n-h)} =  \left(\sum_{n=h}^{h+N-1} x_n W_N^{kn}\right) W_N^{-hk} = X_k W_N^{-hk}$$

para $0 \leq k < N$.

Por otro lado,

$$X_{k-h} = \sum_{n=0}^{N-1} x_n W_N^{k(n-h)} = \sum_{n=0}^{N-1} \left( x_n W_N^{-hk} \right) W_N^{kn} \text{.}$$
:::
