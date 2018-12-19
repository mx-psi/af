# Transformada cuántica de Fourier

## Espacio de estados


El espacio de estados de un sistema cuántico está formado por las rectas de un espacio de Hilbert separable complejo. Las representamos con vectores unitarios.

:::{.example}
Un **qubit** es un sistema cuántico asociado a un espacio de Hilbert $Q$ con $\dim Q = 2$ y una base ortonormal fijada $\ket{0},\ket{1}$. Representamos sus estados como
$$\ket{\psi} = \alpha \ket{0} + \beta \ket{1} \in Q \text{ con } \norm{\ket{\psi}} = |\alpha|^2 + |\beta|^2 = 1$$
$\alpha$ y $\beta$ son las **amplitudes** de $\ket{\psi}$.
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
: $$R_\theta\ket{0} = \ket{0}, \quad R_\theta\ket{1} = e^{i\theta}\ket{1}$$

$U$-controlada
: Si $U$ es unitaria $$C_U\ket{c}\ket{x} = \ket{c}U^c\ket{x}$$ es unitaria.

## Medición

Una medición de un sistema cuántico de dimensión $N = 2^n$ con vector de estado 
$$\ket{\psi} = \sum_{i = 0}^{N-1} \alpha_i\ket{i}$$ 
respecto de la base usual es una variable aleatoria discreta $\operatorname{Med}\ket{\psi}: \Omega \to \{0,1\}^n$ tal que $$P(\operatorname{Med}\ket{\psi} = i) = |\alpha_i|^2 \quad ( i = 0, \dots, N-1)$$

## Modelo de circuitos

:::{.definition}
Un *circuito cuántico $C$ con $n$ entradas* es una sucesión finita $\{(P_j, (i^{(j)}_l)_{l = 1,2,3})\}_{j = 1,\dots, k}$ de pares de operaciones cuánticas sobre 3 qubits e índices $i^{(j)}_l \in \{1,\dots,n\}$.

Dado $\ket{\psi} \in Q^{\otimes n}$, $C(\ket{\psi})$ es el resultado de aplicar ordenadamente para $j = 1\dots k$ la puerta cuántica $P_j$ sobre los qubits $i^{(j)}_l$ de $\ket{\psi}$.
:::

:::{.definition}
Una *familia polinomial uniforme de circuitos cuánticos* es una sucesión de circuitos cuánticos $\{C_n\}_{n \in \mathbb{N}}$ donde $C_n$ tiene $n$ entradas que es calculable en tiempo polinomial (clásico).
:::


## QFT

La transformada discreta de Fourier normalizada puede calcularse de forma eficiente en ordenadores cuánticos.

:::{.theorem}
Existe una familia polinomial uniforme de circuitos cuánticos $\{C_n\}_{n \in \mathbb{N}}$ tales que:

> Si $\ket{\psi} \in Q^{\otimes n}$ tiene vector de amplitudes $x \in \mathbb{C}^{N}$ entonces $C_n(\ket{\psi})$ tiene vector de amplitudes $\operatorname{UFT}(x)$.
:::

En concreto $C_n$ tiene $O(n^2) = O(\log^2 N)$ puertas cuánticas, lo que mejora la eficiencia clásica $O(N \log N)$.

---

:::{.proof}
Usamos que la transformada de Fourier discreta normalizada puede verse como la función
$$\ket{j_1 \dots j_n} \mapsto \frac{1}{\sqrt{2^n}} \left(\ket{0} + e^{2\pi i 0\text{.}j_n}\ket{1}\right)\dots\relax \left(\ket{0} + e^{2\pi i 0\text{.}j_1\dots j_n}\ket{1}\right)$$

![Circuito cuántico para QFT](imgs/qft.png)
:::

## Calculabilidad en tiempo cuántico

:::{.definition}
Una familia de circuitos cuánticos $\{C_n\}_{n \in \mathbb{N}}$ *calcula con error acotado* una función $f: \{0,1\}^\ast \to \{0,1\}^\ast$ si para todo $x \in \{0,1\}^\ast$ con longitud $|x| = n \in \mathbb{N}$ existe $y \in \{0,1\}^\ast$ tal que
$$P\left[\operatorname{Med}C_{n+p(n)}\left(\ket{x}\ket{0}^{\otimes p(n)}\right) = f(x)y\right] \geq \frac23$$
:::

:::{.definition}
Una función $f: \{0,1\}^\ast \to \{0,1\}^\ast$ es *calculable en tiempo polinomial cuántico* si es calculable con error acotado por una familia polinomial uniforme de circuitos cuánticos.
:::

## Estimación de fase
:::{.lemma #lemma:phase}
Sea $U$ una transformación unitaria con un valor propio $e^{2 \pi i\varphi}$ asociado al vector $\ket{u}$.
Si $U$ y $\ket{u}$ son calculables en tiempo polinomial cuántico, una aproximación de $n$-bits de $\varphi$ con error $\varepsilon > 0$ es calculable en tiempo polinomial cuántico ($O(n^2))$.
:::

. . .

### Esbozo de algoritmo

1. El estado inicial es $\ket{0}^{\otimes t} \ket{u}$ ($t = n + \lceil \log(2 + \frac{1}{2\varepsilon})\rceil$),
2. Aplicamos $H$ a los $t$ primeros qubits $\displaystyle\frac{1}{\sqrt{2^t}}\sum_{j = 0}^{2^t - 1} \ket{j} \ket{u}$
3. Aplicamos $U^{2^j}$-controlada por el qubit $j$: $\displaystyle\frac{1}{\sqrt{2^t}}\sum_{j = 0}^{2^t - 1} e^{2\pi i j \varphi_u}\ket{j} \ket{u},$
4. Aplicamos QFT$^{-1}$, obteniendo una aproximación de $\varphi$, $\ket{\overset{\sim}{\varphi}} \ket{u}$

---

### Corrección en el caso exacto

Supongamos que $\varphi = 0\text{.}\varphi_1\dots \varphi_n$ tiene exactamente $n$ bits ($t = n$).
En el paso 3 podemos reescribir lo que obtenemos como:
$$\frac{1}{\sqrt{2^n}}\left(\ket{0} + e^{2\pi i 0\text{.}\varphi_n}\ket{1}\right)\dots\relax \left(\ket{0} + e^{2\pi i 0\text{.}\varphi_1\dots \varphi_n}\ket{1}\right)$$

Utilizando la expresión de QFT vemos que tras aplicar QFT$^{-1}$ es exactamente $\ket{\varphi_1 \dots \varphi_n}$.

## Cálculo del periodo

Dado $N \in \mathbb{Z}$ podemos representarlo como palabra en $\{0,1\}^\ast$ como su representación binaria, de longitud $O(\log N)$.

:::{.theorem}
Sean $N$ entero y $x \in U(\mathbb{Z}_N)$.
El orden de $x$ en el grupo $U(\mathbb{Z}_N)$ es calculable en tiempo polinomial cuántico.
:::

¿Es calculable en tiempo polinomial clásico?

---

### Esbozo de demostración

Consideramos $U\ket{j}\ket{k} = \ket{j}\ket{x^jk \mod N}$. Tenemos que, si $r = \operatorname{ord}(x)$, $$\ket{u_s} = \frac{1}{\sqrt{r}} \sum_{k = 0}^{r-1} \exp\left(\frac{-2\pi i s k}{r}\right)\ket{x^k \mod N}$$ entonces $U\ket{u_s} = \exp(2\pi i s/r)$.

Notamos que:
$$\frac{1}{\sqrt{r}} \sum_{s = 0}^{r-1} \ket{u_s} = \ket{1}$$

Aplicamos el algoritmo de estimación de fase con estado inicial $\ket{1}$.
Obtendremos una aproximación a $s/r$, de la que podemos calcular $r$.
