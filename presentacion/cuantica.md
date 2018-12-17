# Transformada cuántica de Fourier

## Espacio de estados


El espacio de estados de un sistema cuántico está formado por los *rayos* de un espacio de Hilbert separable complejo. Tomamos vectores unitarios.

:::{.example}
Un **qubit** es un sistema cuántico asociado a un espacio de Hilbert $Q$ con $\dim Q = 2$ y una base ortonormal fijada $\ket{0},\ket{1}$. Representamos sus estados como
$$\ket{\psi} = \alpha \ket{0} + \beta \ket{1} \in Q \text{ con } \norm{\ket{\psi}} = |\alpha|^2 + |\beta|^2 = 1.$$
:::

---

El espacio de estados de un sistema compuesto está formado por los rayos del producto tensorial de los espacios de Hilbert de los subsistemas.

:::{.example}
Un sistema compuesto de $n$-qubits tiene espacio de estados $Q^{\otimes n}$, con $\dim Q^{\otimes n} = N = 2^n$.
Por ejemplo, si $n = 2$ el espacio de estados tendrá base 
$$\ket{00}, \ket{01}, \ket{10}, \ket{11}$$

Los representamos con $\ket{0}, \ket{1}, \ket{2}, \ket{3}$.
:::

## Transformaciones unitarias

La evolución del estado de un sistema cuántico viene dada por una transformación unitaria (isometría sobreyectiva).
Las siguientes operaciones son unitarias.

Hadamard
: $$H\ket{0} = \frac{1}{\sqrt{2}}(\ket{0} + \ket{1}) \quad H\ket{1} = \frac{1}{\sqrt{2}}(\ket{0} - \ket{1})$$

Cambio de fase
: $$R_\theta\ket{0} = 0, \quad R_\theta\ket{1} = e^{i\theta}\ket{1}$$

$U$-controlada
: Si $U$ es unitaria $$C_U\ket{c}\ket{x} = \ket{c}U^c\ket{x}$$ es unitaria.

## Medición

Una medición de un sistema cuántico de dimensión $N = 2^n$ con vector de estado 
$$\ket{\psi} = \sum_{i = 0}^{N-1} \alpha_i\ket{i}$$ 
respecto de la base usual es una variable aleatoria discreta $X: \Omega \to \{\ket{0},\dots, \ket{n-1}\}$ tal que $$P(X = \ket{i}) = |\alpha_i|^2 \quad ( i = 0, \dots, N-1)$$

## Modelo de circuitos

:::{.definition}
Un *circuito cuántico $C$ con $n$ entradas* es una sucesión finita $\{(P_j, (i^{(j)}_1,i^{(j)}_2, i^{(j)}_3)\}_{j = 1,\dots, k}$ de pares de operaciones cuánticas sobre 3 qubits e índices $i^{(j)}_l \in \{1,\dots,n\}$.

Dado $C$ y $\ket{\psi} \in Q^{\otimes n}$, $C\ket{\psi}$ es el resultado de medir la salida de $C$ tras aplicar ordenadamente para $j = 1\dots k$ la puerta cuántica $P_j$ sobre los qubits $(i^{(j)}_1,i^{(j)}_2, i^{(j)}_3)$.
:::

---

:::{.definition}
Una familia de circuitos cuánticos $\{C_n\}_{n \in \mathbb{N}}$ donde $C_n$ tiene $p(n) + n$ entradas *calcula con error acotado* una función $f: \{0,1\}^\ast \to \{0,1\}^\ast$ si para todo $x \in \{0,1\}^\ast$ con longitud $|x| = n \in \mathbb{N}$ se tiene que
$$P\left[C_n\left(\ket{x}\ket{0}^{\otimes p(n)}\right) = f(x)\ket{\psi}\right] \geq \frac23$$
:::

. . .

:::{.definition}
Una *familia polinomial uniforme de circuitos cuánticos* es una sucesión de circuitos cuánticos $\{C_n\}_{n \in \mathbb{N}}$ que es calculable en tiempo polinomial (clásico).

Una función $f: \{0,1\}^\ast \to \{0,1\}^\ast$ es *calculable en tiempo polinomial cuántico* si es calculable con error acotado por una familia polinomial uniforme de circuitos cuánticos.
:::


## QFT
## Estimación de fase
## Algoritmo de Shor
