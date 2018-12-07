# Definiciones

A continuación definiremos la transformada discreta de Fourier o DFT (por *discrete Fourier Transform*) y la trasformada discreta de Fourier inversa o IDFT (por *inverse discrete Fourier Transform*).

:::{.definition}
Dada una secuencia $\{x\}=x_0, \dots, x_{N-1}$ de $N$ números complejos, definimos su *transformada discreta de Fourier* $\mathcal{F} \colon \mathbb{C}^N \to \mathbb{C}^N$ como $\mathcal{F}\{x\}= X_0, \dots, X_{N-1}$, donde

$$X_k := \sum_{n=0}^{N-1} x_n e^{\frac{-2 \pi ikn}{N}}$$

para $0 \leq k < N$.

Para mayor brevedad notaremos $W_N := e^{\frac{-2 \pi i}{N}}$, resultando

$$X_k = \sum_{n=0}^{N-1} x_n W_N^{kn} \text{.}$$
:::

:::{.definition}
Dada una secuencia $\{X\}=X_0, \dots, X_{N-1}$ de $N$ números complejos, definimos su *transformada discreta de Fourier inversa* $\mathcal{F}^{-1} \colon \mathbb{C}^N \to \mathbb{C}^N$ como $\mathcal{F}^{-1}\{X\}= x_0, \dots, x_{N-1}$, donde

$$x_k := \frac{1}{N} \sum_{n=0}^{N-1} X_n W_N^{-kn}$$

para $0 \leq k < N$.
:::

## DFT normalizada

En ocasiones conviene usar versiones de la DFT y la IDFT normalizadas o unitarias, esto es, que definan una isometría. Para ello solo tenemos que multiplicar la DFT y la IDFT por una constante de normalización. De esa manera llegamos a las siguientes definiciones:

:::{.definition}
Dada una secuencia $\{x\}=x_0, \dots, x_{N-1}$ de $N$ números complejos, definimos su *transformada discreta de Fourier normalizada* $\operatorname{UDT} \colon \mathbb{C}^N \to \mathbb{C}^N$ como $\operatorname{UDT}\{x\}= X_0, \dots, X_{N-1}$, donde

$$X_k := \frac{1}{\sqrt{N}} \sum_{n=0}^{N-1} x_n W_N^{kn}$$

para $0 \leq k < N$.
:::

:::{.definition}
Dada una secuencia $\{X\}=X_0, \dots, X_{N-1}$ de $N$ números complejos, definimos su *transformada discreta de Fourier inversa normalizada* $\operatorname{UDT}^{-1} \colon \mathbb{C}^N \to \mathbb{C}^N$ como $\operatorname{UDT}^{-1}\{X\}= x_0, \dots, x_{N-1}$, donde

$$x_k := \frac{1}{\sqrt{N}} \sum_{n=0}^{N-1} X_n W_N^{-kn}$$

para $0 \leq k < N$.
:::

Dejaremos para más adelante comprobar que, en efecto, $\operatorname{UDT}$ y $\operatorname{UDT}^{-1}$ definen isometrías con la norma $\| \cdot \|_2$.

## DFT multidimensional

Podemos definir una transformada de Fourier discreta generalizada para el caso de vectores multidimensionales $\{x\} = \{x_{k_1, \dots, k_d} \colon 0 \leq k_1 < N_1, \dots, 0 \leq k_d < N_d \} \in \mathbb{C}^{N_1 \times \dots \times N_d}$ en lugar de secuencias $\{x\} \in \mathbb{C}^N$ que llamaremos DFT multidimensional. La DFT multidimensional será de utilidad para algunas de las aplicaciones que veremos en este trabajo.

:::{.definition}
Dado un vector multidimensional

$$\{x\} = \{x_{k_1, \dots, k_d} \colon 0 \leq k_1 < N_1, \dots, 0 \leq k_d < N_d \} \in \mathbb{C}^{N_1 \times \dots \times N_d} \text{,}$$

definimos su *transformada discreta de Fourier* $\mathcal{F} \colon \mathbb{C}^{N_1 \times \dots \times N_d} \to \mathbb{C}^{N_1 \times \dots \times N_d}$ como $\mathcal{F}\{x\} = X_1, \dots, X_d$, donde

$$X_k := \sum_{n \in N} \left( x_n e^{- 2 \pi i \langle n, k/N \rangle} \right) \text{,}$$
$$N = \{0, 1, \dots, N_1-1\} \times \{0, 1, \dots, N_2-1\} \times \dots \times \{0, 1, \dots, N_d-1\} \text{,}$$
$$k = (k_1, \dots, k_d) \text{,}$$
y
$$k/N = \left(\frac{k_1}{N_1}, \dots, \frac{k_d}{N_d}\right)$$
para $0 \leq k_1 < N_1, \dots, 0 \leq k_d < N_d$.
:::

Así mismo, podemos también generalizar en el mismo sentido la IDFT.

:::{.definition}
Dado un vector multidimensional

$$\{X\} = \{X_{k_1, \dots, k_d} \colon 0 \leq k_1 < N_1, \dots, 0 \leq k_d < N_d \} \in \mathbb{C}^{N_1 \times \dots \times N_d} \text{,}$$

definimos su *transformada discreta de Fourier inversa* $\mathcal{F}^{-1} \colon \mathbb{C}^{N_1 \times \dots \times N_d} \to \mathbb{C}^{N_1 \times \dots \times N_d}$ como $\mathcal{F}^{-1}\{X\} = x_1, \dots, x_n$, donde

$$x_k := \frac{1}{\prod_{r=1}^d N_r} \sum_{n \in N} \left( X_n e^{2 \pi i \langle n, k/N \rangle} \right) \text{,}$$
$$N = \{0, 1, \dots, N_1-1\} \times \{0, 1, \dots, N_2-1\} \times \dots \times \{0, 1, \dots, N_d-1\} \text{,}$$
$$k = (k_1, \dots, k_d) \text{,}$$
y
$$k/N = \left(\frac{k_1}{N_1}, \dots, \frac{k_d}{N_d}\right)$$
para $0 \leq k_1 < N_1, \dots, 0 \leq k_d < N_d$.
:::
