# Definiciones

A continuación definiremos la transformada discreta de Fourier o DFT (por *discrete Fourier Transform*) y la trasformada discreta de Fourier inversa o IDFT (por *inverse discrete Fourier Transform*).

En este trabajo hablaremos a menudo de *secuencias* para referirnos a vectores y usaremos la notación $\{x\} = x_1, \dots, x_{N-1}$ para referirnos al vector $(x_1, \dots, x_{N-1})$.

:::{.definition}
Dada una secuencia $\{x\}=x_0, \dots, x_{N-1}$ de $N$ números complejos, definimos su *transformada discreta de Fourier* $\mathcal{F} \colon \mathbb{C}^N \to \mathbb{C}^N$ como $\mathcal{F}\{x\}= X_0, \dots, X_{N-1}$, donde
$$X_k := \sum_{n=0}^{N-1} x_n e^{\frac{-2 \pi ikn}{N}}$$
para $0 \leq k < N$.

Para mayor brevedad notaremos $W_N := e^{\frac{-2 \pi i}{N}}$, resultando
$$X_k = \sum_{n=0}^{N-1} x_n W_N^{kn} .$$
:::

:::{.definition}
Dada una secuencia $\{X\}=X_0, \dots, X_{N-1}$ de $N$ números complejos, definimos su *transformada discreta de Fourier inversa* $\mathcal{F}^{-1} \colon \mathbb{C}^N \to \mathbb{C}^N$ como $\mathcal{F}^{-1}\{X\}= x_0, \dots, x_{N-1}$, donde
$$x_k := \frac{1}{N} \sum_{n=0}^{N-1} X_n W_N^{-kn}$$
para $0 \leq k < N$.
:::

## Forma matricial de la DFT

Una manera de ver la DFT que resulta de utilidad es como la multiplicación de una matriz por un vector. En efecto, podemos ver que
$$\mathcal{F}\{x\} = F \left( \begin{array}{c} x_0 \\ \vdots \\ x_{N-1} \end{array} \right) ,$$
donde
$$F = \left( \begin{array}{cccc}
W_N^{0 \cdot 0} & W_N^{0 \cdot 1} & \cdots & W_N^{0(N-1)}     \\
W_N^{1 \cdot 0} & W_N^{1 \cdot 1} & \cdots & W_N^{1(N-1)}     \\
\vdots          & \vdots          & \ddots & \vdots           \\
W_N^{(N-1) 0}   & W_N^{(N-1) 1}   & \cdots & W_N^{(N-1)(N-1)} \\
\end{array} \right).$$

De la misma manera, se tiene
$$\mathcal{F}^{-1}\{x\} = \frac{1}{N} G \left( \begin{array}{c} x_0 \\ \vdots \\ x_{N-1} \end{array} \right),$$
donde
$$G = \left( \begin{array}{cccc}
W_N^{-0 \cdot 0} & W_N^{-0 \cdot 1} & \cdots & W_N^{-0(N-1)}     \\
W_N^{-1 \cdot 0} & W_N^{-1 \cdot 1} & \cdots & W_N^{-1(N-1)}     \\
\vdots          & \vdots          & \ddots & \vdots           \\
W_N^{-(N-1) 0}   & W_N^{-(N-1) 1}   & \cdots & W_N^{-(N-1)(N-1)} \\
\end{array} \right).$$

:::{.proposition}
Definiendo $u_k := \left( W_N^{k0}, W_N^{k1}, \dots, W_N^{k(N-1)}\right)$, los vectores $\{u_0, u_1, \dots, u_{N-1}\}$ forman una base ortogonal de $\mathbb{C}^N$.
:::
:::{.proof}
Sabemos que $F = (u_0 | u_1 | \dots | u_{N-1}) = F^T$. $F$ es una matriz de Vandermonde, luego $\det(F) = \prod_{0 \leq i < j < N} (W_N^i - W_N^j) \neq 0$ y los vectores $\{u_0, u_1, \dots, u_{N-1}\}$ son linealmente independientes.

Veamos la ortogonalidad. Para $i, j \in \{0, \dots, N-1\}$,
$$\langle u_i, u_j \rangle = \sum_{n=0}^{N-1} W_N^{-in} W_N^{jn} = \sum_{n=0}^{N-1} W_N^{(j-i)n}.$$

De esta fórmula se ve que, si $i=j$, $\langle u_i, u_j \rangle = N$, mientras que si $i \neq j$ se tiene $\langle u_i, u_j \rangle = 0$ ya que
$$W_N^{(j-i)} \langle u_i, u_j \rangle = \sum_{n=0}^{N-1} W_N^{(j-i)(n+1)} = \sum_{n=1}^{N} W_N^{(j-i)n} = \sum_{n=0}^{N-1} W_N^{(j-i)n} = \langle u_i, u_j \rangle,$$
luego $\langle u_i, u_j \rangle = N \delta_{ij}$.
:::
:::{.corollary}
$\mathcal{F}$ es un automorfismo.
:::

Ahora estamos en condiciones de probar que efectivamente $\mathcal{F} \circ \mathcal{F}^{-1} = \mathcal{F}^{-1} \circ \mathcal{F} = \operatorname{id}$.

:::{.proposition}
Se verifica $\mathcal{F} \circ \mathcal{F}^{-1} = \mathcal{F}^{-1} \circ \mathcal{F} = \operatorname{id}$.
:::
:::{.proof}
Basta ver que
$$\begin{split}
GF & = \left( \begin{array}{cccc}
\langle u_1, u_1 \rangle     & \langle u_1, u_2 \rangle     & \cdots & \langle u_1, u_{N-1} \rangle     \\
\langle u_2, u_1 \rangle     & \langle u_2, u_2 \rangle     & \cdots & \langle u_2, u_{N-1} \rangle     \\
\vdots                       & \vdots                       & \ddots & \vdots                           \\
\langle u_{N-1}, u_1 \rangle & \langle u_{N-1}, u_2 \rangle & \cdots & \langle u_{N-1}, u_{N-1} \rangle \\
\end{array}\right) \\
& =\left( \begin{array}{cccc}
N\delta_{11} & N\delta_{12} & \cdots & N\delta_{1(N-1)}             \\
N\delta_{21} & N\delta_{22} & \cdots & N\delta_{2(N-1)}             \\
\vdots       & \vdots       & \ddots & \vdots                       \\
N\delta_{(N-1)1} & N\delta_{(N-1)2} & \cdots & N\delta_{(N-1)(N-1)} \\
\end{array}\right) = NI
\end{split}$$
y $FG = \left(G^T F^T\right)^T = (GF)^T = NI$.
:::

## DFT normalizada

En ocasiones conviene usar versiones de la DFT y la IDFT normalizadas o unitarias, esto es, que definan una isometría. Para ello solo tenemos que multiplicar la DFT y la IDFT por una constante de normalización. De esa manera llegamos a las siguientes definiciones:

:::{.definition #dfn:udt}
Dada una secuencia $\{x\}=x_0, \dots, x_{N-1}$ de $N$ números complejos, definimos su *transformada discreta de Fourier normalizada* $\operatorname{UDT} \colon \mathbb{C}^N \to \mathbb{C}^N$ como $\operatorname{UDT}\{x\}= X_0, \dots, X_{N-1}$, donde
$$X_k := \frac{1}{\sqrt{N}} \sum_{n=0}^{N-1} x_n W_N^{kn}$$
para $0 \leq k < N$.
:::

:::{.definition}
Dada una secuencia $\{X\}=X_0, \dots, X_{N-1}$ de $N$ números complejos, definimos su *transformada discreta de Fourier inversa normalizada* $\operatorname{UDT}^{-1} \colon \mathbb{C}^N \to \mathbb{C}^N$ como $\operatorname{UDT}^{-1}\{X\}= x_0, \dots, x_{N-1}$, donde
$$x_k := \frac{1}{\sqrt{N}} \sum_{n=0}^{N-1} X_n W_N^{-kn}$$
para $0 \leq k < N$.
:::

Dejaremos para más adelante ([@cor:isometries]) comprobar que, en efecto, $\operatorname{UDT}$ y $\operatorname{UDT}^{-1}$ definen isometrías con la norma $\| \cdot \|_2$.

## DFT multidimensional

Podemos definir una transformada de Fourier discreta generalizada para el caso de vectores multidimensionales $\{x\} = \{x_{k_1, \dots, k_d} \colon 0 \leq k_1 < N_1, \dots, 0 \leq k_d < N_d \} \in \mathbb{C}^{N_1 \dots N_d}$ en lugar de secuencias $\{x\} \in \mathbb{C}^N$ que llamaremos DFT multidimensional. La DFT multidimensional será de utilidad para algunas de las aplicaciones que veremos en este trabajo.

:::{.definition}
Dado un vector multidimensional
$$\{x\} = \{x_{k_1, \dots, k_d} \colon 0 \leq k_1 < N_1, \dots, 0 \leq k_d < N_d \} \in \mathbb{C}^{N_1 \dots N_d},$$
definimos su *transformada discreta de Fourier* $\mathcal{F} \colon \mathbb{C}^{N_1 \dots N_d} \to \mathbb{C}^{N_1 \dots N_d}$ como $\mathcal{F}\{x\} = X_1, \dots, X_d$, donde
$$X_k := \sum_{n \in N} \left( x_n e^{- 2 \pi i \langle n, k/N \rangle} \right) ,$$
$$N = \{0, 1, \dots, N_1-1\} \times \{0, 1, \dots, N_2-1\} \times \dots \times \{0, 1, \dots, N_d-1\} ,$$
$$k = (k_1, \dots, k_d) ,$$
y
$$k/N = \left(\frac{k_1}{N_1}, \dots, \frac{k_d}{N_d}\right)$$
para $0 \leq k_1 < N_1, \dots, 0 \leq k_d < N_d$.
:::

Así mismo, podemos también generalizar en el mismo sentido la IDFT.

:::{.definition}
Dado un vector multidimensional
$$\{X\} = \{X_{k_1, \dots, k_d} \colon 0 \leq k_1 < N_1, \dots, 0 \leq k_d < N_d \} \in \mathbb{C}^{N_1 \dots N_d} ,$$
definimos su *transformada discreta de Fourier inversa* $\mathcal{F}^{-1} \colon \mathbb{C}^{N_1 \dots N_d} \to \mathbb{C}^{N_1 \dots N_d}$ como $\mathcal{F}^{-1}\{X\} = x_1, \dots, x_n$, donde
$$x_k := \frac{1}{\prod_{r=1}^d N_r} \sum_{n \in N} \left( X_n e^{2 \pi i \langle n, k/N \rangle} \right) ,$$
$$N = \{0, 1, \dots, N_1-1\} \times \{0, 1, \dots, N_2-1\} \times \dots \times \{0, 1, \dots, N_d-1\} ,$$
$$k = (k_1, \dots, k_d) ,$$
y
$$k/N = \left(\frac{k_1}{N_1}, \dots, \frac{k_d}{N_d}\right)$$
para $0 \leq k_1 < N_1, \dots, 0 \leq k_d < N_d$.
:::

## Convolución discreta

De manera análoga al caso continuo, en el caso discreto podemos definir una operación de convolución y un Teorema de Convolución que la relacione con la transformada de Fourier.

:::{.definition}
Dadas dos secuencias $\{x\} = x_1, \dots, x_N$, $\{y\} = y_1, \dots, y_N$ de $N$ números complejos, definimos su convolución $\{x\} \ast \{y\} := \{z\}$ como $\{z\} = z_1, \dots, z_N$, donde
$$z_k := \frac{1}{N} \sum_{n=0}^{N-1} x_n y_{k-n}$$
y $x_{k \pm N} := x_k, y_{k \pm N} := y_k$ para $0 \leq k < N$.
:::

También necesitaremos definir el producto de dos secuencias, que no es más que su producto elemento a elemento.

:::{.definition}
Dadas dos secuencias $\{x\} = x_1, \dots, x_N$, $\{y\} = y_1, \dots, y_N$ de $N$ números complejos, definimos su producto como $\{x\} \{y\} := x_0 y_0, \dots, x_{N-1} y_{N-1}$ para $0 \leq m < N$.
:::
