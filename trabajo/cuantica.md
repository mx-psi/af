# La transformada de Fourier cuántica

En esta sección describimos el algoritmo cuántico de cálculo de la transformada de Fourier y algunas aplicaciones.

La computación cuántica es el estudio de un nuevo tipo de ordenador que utiliza los principios de la mecánica cuántica para obtener algoritmos más eficientes que los actuales.
Aunque su implementación física a gran escala no es todavía una realidad, desde los años 80 [@deutsch1985quantum] existe un campo que investiga de forma teórica qué problemas pueden resolverse de forma eficiente en estos ordenadores.

Entre los problemas para los que existen algoritmos eficientes está el cálculo de la transformada de Fourier cuántica, una versión unitaria de la transformada de Fourier discreta para la que conocemos un algoritmo cuántico mucho más eficiente que cualquier algoritmo de transformada de Fourier rápida conocido.
Sin embargo este algoritmo está limitado debido a la forma en la que se obtienen los resultados, por lo que el diseño de aplicaciones es complejo.

La aplicación más conocida de la transformada de Fourier cuántica es el algoritmo de Shor[@shor1999polynomial] que permite la factorización de enteros en tiempo polinómico y su generalización en el problema del subgrupo abeliano oculto [@jozsa1998quantum] con otras aplicaciones para la resolución de problemas algebraicos[@hallgren2007polynomial],[@biasse2016efficient].

## Principios de la mecánica cuántica

El modelo habitual de ordenadores cuánticos viene dado por un sistema cuántico aislado en el que se permiten algunas operaciones básicas dadas por transformaciones unitarias. En esta sección describimos los principios de mecánica cuántica que utilizamos para definir nuestro modelo.

La implementación concreta de los ordenadores cuánticos requiere de un proceso de corrección de errores ya que los sistemas cuánticos no son aislados. Existen resultados que nos garantizan que podemos realizar esa corrección de errores de forma eficiente si el ruido del sistema no supera un cierto umbral y podemos suponer sin pérdida de generalidad por tanto que el sistema es aislado [@fowler2009high].

### Espacio de estados

En primer lugar definimos el espacio de estados de un sistema cuántico:

:::{.principle}
El *espacio de estados* de un sistema cuántico (aislado) es el espacio proyectivo asociado a un espacio de Hilbert complejo y separable. Es decir, los estados de un sistema cuántico se identifican con los subespacios de dimensión 1 (*rayos*) de un espacio de Hilbert complejo separable.
:::

La computación cuántica se restringe tradicionalmente a sistemas cuánticos de dimensión finita, por lo que podemos tomar como espacio de estados canónico $\mathbb{P}\mathbb{C}^N$. En lugar de trabajar en el espacio proyectivo escogemos un representante de norma 1 de cada rayo (*vector de estado*).

Utilizamos la notación habitual en mecánica cuántica, en la que los vectores del espacio de Hilbert se representan por *kets* de la forma $\ket{\psi}, \ket{\psi}$. Cada ket tiene asociado un *bra*, que en el caso finito podemos identificar con su adjunto conjugado $\bra{\psi} = \ket{\psi}^\dagger$. De esta forma el producto escalar se define $(\ket{\psi},\ket{\phi}) := \bk{\psi}{\phi} := \ket{\psi}^\dagger \ket{\phi}$.

Un **qubit** es un sistema cuántico con espacio de estados de dimensión 2 con una base ortonormal $(\ket{0},\ket{1})$. El término se utiliza también para referirse a un estado concreto; utilizando la identificación con representantes de norma 1 tenemos que un qubit es por tanto un vector $$\ket{\psi} = \alpha \ket{0} + \beta \ket{1} \text{ tal que } \norm{\ket{\psi}} = |\alpha|^2 + |\beta|^2 = 1.$$
$\alpha$ y $\beta$ son las amplitudes de $\ket{0}$ y $\ket{1}$ respectivamente.

En computación cuántica nos restringimos a sistemas compuestos por qubits. Esta restricción no supone ningún cambio en términos de qué problemas pueden resolverse eficientemente en un ordenador cuántico[@NielsenQuantumComputationQuantum2010].

### Sistemas compuestos

El espacio de estados de un sistema compuesto viene dado por el producto tensorial.
Recordamos en la siguiente proposición la construcción de un espacio de Hilbert a partir del producto tensorial de dos espacios de Hilbert, cuya demostración puede encontrarse en [@weidmann2012linear].

:::{.proposition #prop:hilbert}
Sean $H_1, H_2$ espacios de Hilbert con bases ortonormales $B_1 = \{u_i\}_{i \in I}, B_2 = \{v_j\}_{j \in J}$. Entonces el producto tensorial de $H_1, H_2$ como espacios vectoriales  tiene estructura de espacio de Hilbert con producto escalar dado por la extensión sesquilineal y continua de
$$\bk{u \otimes v}{u' \otimes v'} = \bk{u}{u'} \bk{v}{v'}$$
y $B_1 \otimes B_2 := \{u_i \otimes v_j\}_{(i,j)}$ es una base ortonormal.
:::

De esta forma está justificado el siguiente principio:

:::{.principle}
El espacio de estados de un sistema compuesto es el espacio proyectivo asociado al producto tensorial de los espacios de Hilbert de sus subsistemas.
:::

Siguiendo la notación habitual escribiremos $\ket{\phi \psi} := \ket{\phi} \otimes \ket{\psi}$.
El vector de estado asociado a un rayo de un sistema compuesto es el producto tensorial de los vectores de estado de sus subsistemas.

Un sistema de $n$ qubits tiene un espacio de estados de dimensión $N = 2^n$.
Fijamos como base ortonormal de un sistema compuesto de $n$ qubits la base obtenida en la [ @prop:hilbert].
Como cada qubit $Q_i$ tiene una base ortonormal fijada $\ket{0}_i, \ket{1}_i$ los elementos de esta base son de la forma: $$\ket{a_0\dots a_{n-1}} := \ket{a_0} \otimes \cdots \otimes \ket{a_{n-1}} \qquad (a_i \in \{0,1\}),$$
y podemos entonces identificar cada elemento de la base con un número de 0 a $2^n - 1$ en función del número que representa en binario, justificando la siguiente notación: $$\text{Si } k = \sum_{i = 0}^{n-1} a_i2^{n-i} \quad (a_i \in \{0,1\}) \qquad \text{ entonces } \ket{k} := \ket{a_0 \dots a_{n-1}}.$$

### Operaciones cuánticas

De manera análoga a los modelos de computación clásicos los ordenadores cuánticos consideran el tiempo de forma discreta.
En este contexto se permiten dos tipos de operaciones: transformaciones unitarias (isométricas) que son deterministas y nos mantienen en el ámbito cuántico y mediciones que son no deterministas, irreversibles, y permiten comunicar el mundo cuántico con el clásico.

Dado un operador $A : H \to H'$ entre espacios de Hilbert notamos su aplicación a un elemento $\ket{\psi} \in H$ como $A\ket{\psi} := A(\ket{\psi})$. En dimensión finita, identificamos el operador con su matriz respecto de la base usual de tal forma que $A$ puede referirse al operador o a $\mathcal{M}(A, B_u, B_u)$.

Las operaciones cuánticas se corresponden con operadores unitarios

:::{.principle}
La evolución del estado de un sistema cuántico $\ket{\psi(t)}$ de un tiempo $t$ a un tiempo $t+1$ viene dada por una transformación unitaria $U$, esto es $$\ket{\psi(t+1)} = U\ket{\psi(t)}$$
:::

No todas las transformaciones unitarias son físicamente realizables, pero sí que podemos aproximarlas de forma eficiente a partir de un *conjunto universal* de transformaciones.
Por simplicidad tomamos como conjunto universal para este trabajo las operaciones unitarias que actúan sobre 3 qubits, aunque existen conjuntos universales finitos[@NielsenQuantumComputationQuantum2010 p. 189].

Por último las mediciones en el caso finito nos dan una variable aleatoria discreta.
Aunque el modelo general cuántico admite mediciones más generales que las que describimos a continuación el principio que presentamos es suficiente para simular, modificando convenientemente el ordenador cuántico con operaciones unitarias adecuadas cualquier medición arbitraria.

:::{.principle}
Una medición de un sistema cuántico de dimensión $N = 2^n$ con vector de estado $$\ket{\psi} = \sum_{i = 0}^{N-1} \alpha_i\ket{i}$$ es una variable aleatoria discreta $X: \Omega \to \{\ket{0},\dots, \ket{n-1}\}$ tal que $$P(X = \ket{i}) = |\alpha_i|^2 \quad ( i = 0, \dots, N-1)$$
:::

Como los vectores de estado son vectores unitarios tenemos que la variable aleatoria $X$ está bien definida ya que $$1 = \norm{\ket{\psi}}^2 = \sum_{i = 0}^{N-1} |\alpha_i|^2$$


### Algunos ejemplos de operaciones unitarias

Existen una gran cantidad de operaciones unitarias que se utilizan en computación cuántica; en este trabajo nos restringimos a aquellas que tienen aplicación para el algoritmo de la transformada cuántica de Fourier.

:::{.proposition #prop:unitary}
Las siguientes operaciones son unitarias:

1. La identidad $I_n$,
2. La *puerta cuántica de Hadamard* es la operación unitaria dada por la expresión matricial $$H = \frac{1}{\sqrt{2}}\left(\begin{matrix} 1 & 1 \\ 1 & -1 \end{matrix}\right), \qquad H\ket{0} = \frac{1}{\sqrt{2}}(\ket{0} + \ket{1}) \quad H\ket{1} = \frac{1}{\sqrt{2}}(\ket{0} - \ket{1}),$$
3. Si $\theta \in [0,2\pi]$, la *puerta de cambio de fase $R_\theta$*,
$$R_\theta = \left(\begin{matrix}1 & 0 \\ 0 & e^{i\theta}\end{matrix}\right), \qquad R_\theta\ket{0} = 0, \quad R_\theta\ket{1} = e^{i\theta}\ket{1}$$
:::
:::{.proof}
Basta comprobar en cada caso que el producto de la expresión matricial por su adjunta conjugada da la identidad.
:::

Además, a partir de estas operaciones podemos construir otras nuevas operaciones unitarias.
En concreto necesitaremos dos tipos de operaciones:

:::{.definition #dfn:controlled}
$\;$

1. Dados dos operadores lineales $A_i : H_i \to H'_i$ ($i = 1,2$) existe una única aplicación lineal $A_1 \otimes A_2 : H_1 \otimes H_2 \to H'_1 \otimes H'_2$ tal que
$$(A_1 \otimes A_2)(\ket{x} \otimes \ket{y}) = (A_1\ket{x}) \otimes (A_2\ket{y}),$$
conocida como su *producto tensorial*.
Si $A_1$y $A_2$ son unitarias también lo será $A_1 \otimes A_2$.
2. Si $A$ es una operación unitaria podemos definir la operación $A$*-controlada* como la operación unitaria dada por la expresión matricial por bloques
$$C_A= \left(\begin{array}{c|c} I_2 & 0 \\ \hline 0 & A \end{array} \right), \qquad C_A\ket{0}\ket{x} = \ket{0}\ket{x}, \quad C_A\ket{1}\ket{x} = \ket{1}A\ket{x}$$
esta operación toma un qubit $\ket{a}$ y aplica de forma condicional la operación $A$ al resto de qubits si $\ket{a} = \ket{1}$ o lo deja igual si $\ket{a} = \ket{0}$.
:::

Estas operaciones nos permiten componer operaciones unitarias básicas para crear una nueva operación unitaria que actúe sobre un mayor número de qubits.

## El modelo de circuitos cuánticos

A partir de este modelo físico que asumimos como dado construimos un modelo de computador cuántico.
Existen diversos modelos equivalentes que formalizan la noción de un algoritmo cuántico pero en este trabajo nos centramos en el modelo de *circuitos cuánticos*, que es el más utilizado.

:::{.definition}
Un *circuito cuántico $C$ con $n$ entradas* es una sucesión finita de pares de operaciones cuánticas sobre 3 qubits de un conjunto universal e índices $\{(P_1, (i^{(1)}_1,i^{(1)}_2, i^{(1)}_3)), \dots, (P_k, (i^{(k)}_1, i^{(k)}_2, i^{(k)}_3))\}$ con $1 \leq i^{(j)}_l \leq n$.

Si $\ket{\psi}$ es un estado cuántico, notamos con $C(\ket{\psi})$ la variable aleatoria resultante de medir respecto de la base usual el estado cuántico tras aplicar ordenadamente las puertas cuánticas $P_j$ sobre los qubits $(i^{(j)}_1,i^{(j)}_2, i^{(j)}_3)$ dejando el resto de qubits sin modificar en ese paso.
:::

Aunque la elección de conjunto universal dará lugar a circuitos cuánticos distintos todos dan lugar a la misma definición de calculabilidad en tiempo polinomial cuántico [@dawson2005solovay].

La noción de familia de circuitos cuánticos nos permite formalizar el cálculo de funciones $f:\{0,1\}^\ast \to \{0,1\}^\ast$. Como las mediciones son probabilísticas el resultado del cálculo por parte de una familia de circuitos cuánticos será, en general, no determinista, lo que formaliza la siguiente definición.

Para el cálculo de funciones debemos asumir que dada $x \in \{0,1\}^\ast$ arbitraria podemos preparar el estado inicial asociado $\ket{x}$ en como mucho $n = |x|$ pasos. Incluimos también *qubits ancilla* para cálculos auxiliares.

:::{.definition}
Una familia de circuitos cuánticos $\{C_n\}_{n \in \mathbb{N}}$ donde $C_n$ tiene $p(n) + n$ entradas *calcula con error acotado* una función $f: \{0,1\}^\ast \to \{0,1\}^\ast$ si para todo $x \in \{0,1\}^\ast$ con longitud $|x| = n \in \mathbb{N}$ se tiene que
$$P\left[C_n\left(\ket{x}\ket{0}^{\otimes p(n)}\right) = f(x)\ket{\psi}\right] \geq \frac23$$
:::

La constante $\frac23$ es arbitraria; dada una familia de circuitos cuánticos que calcule una función $f$ con probabilidad de éxito no nula podemos calcularla con probabilidad de éxito tan cercana a 1 como queramos sin más que repetir el algoritmo una cantidad constante de veces.

Por último nos restringimos a familias de circuitos cuánticos que podamos calcular eficientemente.

:::{.definition}
Una *familia polinomial uniforme de circuitos cuánticos* es una sucesión de circuitos cuánticos $\{C_n\}_{n \in \mathbb{N}}$ calculable en tiempo polinomial (clásico).

Una función $f: \{0,1\}^\ast \to \{0,1\}^\ast$ es *calculable en tiempo polinomial cuántico* si es calculable con error acotado por una familia polinomial uniforme de circuitos cuánticos.
:::

El concepto de calculabilidad en tiempo polinomial cuántico formaliza qué funciones podemos calcular de forma eficiente mediante un ordenador cuántico. Toda función calculable en tiempo polinomial clásico lo es en tiempo cuántico[@NielsenQuantumComputationQuantum2010], por lo que para simplificar la presentación los algoritmos tendrán una parte clásica y otra cuántica.

## Transformada de Fourier cuántica

En esta sección definimos la transformada de Fourier cuántica y vemos cómo calcularla de forma eficiente en ordenadores cuánticos. En primer lugar recordamos que, como vimos en el [@cor:isometries], la transformada discreta de Fourier normalizada es una transformación unitaria, por lo que tiene sentido considerarla como operación en el contexto de la computación cuántica.

:::{.definition}
Sea $$\ket{\phi} = \sum_{k = 0}^{N-1} c_k\ket{k}$$ un estado cuántico de un sistema compuesto.
Su *transformada de Fourier cuántica* es el estado cuántico que surge de la aplicación de la transformada discreta de Fourier normalizada ([@dfn:udt]) a su vector de coordenadas:
$$\ket{\operatorname{UDT}(\phi)} = \sum_{x = 0}^{N-1} (\operatorname{UDT} c)_x\ket{x}$$
:::

Explícitamente, la transformada es la aplicación unitaria que transforma el estado $\ket{x}, x \in \{0, \dots, 2^n-1\}$ de la base usual de la siguiente forma
$$\ket{x} \mapsto \frac{1}{\sqrt{2^n}} \sum_{k = 0}^{2^n-1} e^{2 \pi i x k/2^n}\ket{k},$$
o, mediante cálculos sencillos vemos que podemos reescribirla de la siguiente forma, donde $x = x_1 \dots x_n$ es la expresión de $x$ en binario
\begin{equation}
\label{eq:binary}
\ket{x_1 \dots x_n} \mapsto \frac{1}{\sqrt{2^n}} \left(\ket{0} + e^{2\pi i 0.x_n}\ket{1}\right)\dots\relax \left(\ket{0} + e^{2\pi i 0.x_1\dots x_n}\ket{1}\right)
\end{equation}

El principal resultado de esta sección es:

:::{.theorem #thm:dftc}
Existe una familia polinomial uniforme de circuitos cuánticos cuya salida para cada estado cuántico es su transformada de Fourier cuántica.

En concreto, para un estado cuántico de $N = 2^n$ coeficientes complejos el circuito tiene un tamaño de $O(n^2)$, luego su eficiencia es $O(\log^2 N)$.
:::
:::{.proof}
La demostración está adaptada de [@NielsenQuantumComputationQuantum2010].

Supongamos que la entrada tiene $n$ bits y es de la forma $\ket{x} = \ket{x_1 \dots x_n}$.
Siguiendo la notación de la [@prop:unitary] notamos para $2 \leq k \leq n$, $R_k := R_{2\pi/2^k}$.

C1aramente $$H\ket{x_1} = \frac{1}{\sqrt{2}}(\ket{0} + e^{2 \pi i 0.x_1}\ket{1}),$$ ya que $e^{2 \pi 0.x_1} = (-1)^{x_1}$.

Si aplicamos una puerta $R_2$-controlada ([@dfn:controlled]) respecto de $\ket{x_2}$ tenemos
$$\operatorname{C-R}_2\ket{x_2}(H\ket{x_1}) = \frac{1}{\sqrt{2}}(\ket{0} + e^{2 \pi i 0.x_1x_2}\ket{1})$$

Generalizando, mediante la aplicación de puertas de Hadamard y puertas $R_k$-controladas podemos obtener un circuito que calcule la transformada de Fourier ([@fig:circuito]) a partir de la [@eq:binary] que necesita un total de $\frac{n(n+1)}{2} \in O(n^2)$ puertas cuánticas.

![Circuito cuántico para el cálculo de la transformada cuántica de Fourier para entrada de $n$-qubits. No se incluye la reordenación de qubits final[@QFTcircuito].](imgs/Q_fourier_nqubits.png){#fig:circuito}

:::

Nótese que no se conoce una forma de aprovechar esta familia de circuitos para el cálculo directo de la transformada discreta de Fourier normalizada (esto es, no sabemos si la transformada discreta de Fourier es calculable en tiempo cuántico $O(\log^2 N)$) ya que no podemos observar las amplitudes del estado cuántico, sólo realizar mediciones.

A pesar de esta importante limitación esta familia polinomial uniforme de circuitos cuánticos puede utilizarse para el cálculo de funciones en tiempo polinomial cuántico que no conocemos que puedan ser calculadas en tiempo polinomial clásico, como es el caso de la factorización de enteros que veremos en la próxima sección.

## El algoritmo de Shor

En esta sección describimos una de las principales aplicaciones de la QFT en la computación cuántica: el **algoritmo de Shor**. Seguimos la presentación de [@NielsenQuantumComputationQuantum2010].

Este algoritmo permite calcular en tiempo polinomial cuántico los factores de un entero, lo que permitiría romper algunos sistemas criptográficos muy utilizados en la actualidad[@NielsenQuantumComputationQuantum2010].
Consta de una parte clásica y una parte cuántica.

El tiempo de ejecución del algoritmo será de $O(\log^3 N)$ para encontrar un factor o de $O(\log^4 N)$ para encontrar todos los factores.
Notamos que el tiempo de ejecución depende del logaritmo de $N$ dado que $N$ se da como entrada al algoritmo como su expresión en binario que tiene $\lceil \log N\rceil$ dígitos.

### Parte cuántica

En primer lugar discutimos la parte cuántica que hace uso de la transformada de Fourier cuántica.
El algoritmo que proporcionamos demuestra el siguiente lema:

:::{.lemma #lemma:phase}
Sea $U$ una transformación unitaria con un valor propio $e^{2 \pi i\varphi}$.
Una aproximación de $n$-bits de $\varphi$ es calculable en tiempo polinomial cuántico ($O(n^2))$.
:::

:::{.algorithm #algo:phase name="Estimación de fase"}

$\;$

Entrada
: Una operación unitaria que realiza la operación $U^j$-controlada para $j$ entero, un vector propio $\ket{u}$ de $U$ con valor propio $e^{2 \pi \varphi_u}$ y $t = n + \lceil \log(2 + \frac{1}{2\varepsilon})\rceil$ qubits inicializados a $\ket{0}$.

Salida
: Una aproximación de $n$ bits a $\varphi_u$ con probabilidad de éxito $1 - \varepsilon$.

1. El estado inicial es $\ket{0}^{\otimes t} \ket{u}$,
2. creamos una superposición en los $t$ primeros qubits utilizando puertas de Hadamard, obteniendo el estado
$$\frac{1}{\sqrt{2^j}}\sum_{j = 0}^{2^t - 1} \ket{j} \ket{u}$$
3. \label{paso:ucontrolada} Aplicamos la operación $U^j$-controlada. Reordenando términos
$$\frac{1}{\sqrt{2^j}}\sum_{j = 0}^{2^t - 1} e^{2\pi i j \varphi_u}\ket{j} \ket{u},$$
4. Aplicamos la transformada de Fourier cuántica inversa, obteniendo una aproximación de $\varphi_u$,
$$\ket{\overset{\sim}{\varphi_u}} \ket{u}$$
5. Medimos el primer registro.
:::

Supongamos que $\varphi_u = 0.\varphi_1\dots \varphi_n$ tiene exactamente $n$ bits.
En tal caso el estado después del [@paso:ucontrolada] es
$$\frac{1}{\sqrt{2^n}}\left(\ket{0} + e^{2\pi i 0.\varphi_n}\ket{1}\right)\dots\relax \left(\ket{0} + e^{2\pi i 0.\varphi_1\dots \varphi_n}\ket{1}\right)$$
y utilizando [@eq:binary] vemos que la salida del algoritmo tras aplicar la transformada de Fourier cuántica inversa es exactamente $\ket{\varphi_1 \dots \varphi_n}$.
No desarrollamos la demostración de la corrección del [@algo:phase] en el caso general, cuyos detalles pueden consultarse en [@NielsenQuantumComputationQuantum2010].

A partir del [@lemma:phase] probamos que el cálculo de la parte cuántica del algoritmo de Shor puede hacerse en tiempo polinomial cuántico:

:::{.lemma #lemma:orden}
Sean $N$ entero y $x \in U(\mathbb{Z}_N)$.
El orden de $x$ en el grupo $U(\mathbb{Z}_N)$ es calculable en tiempo polinomial cuántico.
:::
:::{.proof}
Consideramos la aplicación unitaria $U$
$$\ket{j}\ket{k} \mapsto\ket{j}\ket{x^jk \mod N}$$

Sea $r$ el periodo de $x$ ($\mod N$), $0 \leq s\leq r-1$. Puede verificarse que
$$\ket{u_s} = \frac{1}{\sqrt{r}} \sum_{k = 0}^{r-1} \exp\left(\frac{-2\pi i s k}{r}\right)\ket{x^k \mod N}$$
es un vector propio de $U$ con valor propio $\exp(\frac{2 \pi i s}{r})$.

Por tanto, si podemos construir $U$ y $\ket{u_s}$ podremos aplicar el [@algo:phase] para calcular una aproximación a $\frac{s}{r}$, de la que podemos deducir $r$ en tiempo polinomial mediante un algoritmo de fracciones continuas.

El cálculo de $U^{2^j}$ es eficiente mediante exponenciación binaria. Para el cálculo de $\ket{u_s}$ notamos que $$\frac{1}{\sqrt{r}} \sum_{s = 0}^{r-1} \ket{u_s} = \ket{1},$$ luego podemos aplicar el algoritmo sobre esta superposición y obtendremos la fracción $\frac{s}{r}$ para algún $s$.

Combinando estos hechos obtenemos un algoritmo que aproxima $\frac{s}{r}$.
Una análisis sencillo nos muestra que utilizando $t = 2\log N + 1 + \lceil \log(2 + \frac{1}{2 \varepsilon})\rceil$ podemos aproximar esta fracción con la precisión suficiente como para recuperar $r$.
:::

Por último, la parte clásica reduce el problema de factorización al cálculo del orden de un cierto elemento.

### Parte clásica

El funcionamiento de la parte clásica del algoritmo de Shor viene dado por los siguientes dos teoremas, cuyo enunciado y demostración se han adaptado de [@NielsenQuantumComputationQuantum2010]:

:::{.theorem #thm:divisores}
Sea $N$ un número compuesto y $x \in \mathbb{Z}_N, x \notin \{-1,1\}$ una solución a la ecuación $x^2 = 1 \, \mod N$.
Entonces $\gcd(x-1,N)$ es un divisor no trivial de $N$ calculable en tiempo $O(\log^3 N)$.
:::
:::{.proof}
Por hipótesis $N | (x+1)(x-1)$, pero $x-1 < x+1 < N$, luego $N \not|(x+1)$ y $N \not|(x-1)$.

Supongamos que $x-1$ fuera coprimo con $N$ entonces, por la identidad de Bézout y usando que $x^2 -1 = Nk$,
$$aN + b(x-1) = 1 \implies aN(x+1) + b(x^2-1) = x+1 \implies N(a(x+1) + bK) = x+1 \implies N |x+1$$
lo que es una contradicción.

Por tanto $\gcd(x-1,N) \neq 1$. Además $\gcd(x-1,N) < N$, por lo que es un divisor no trivial de $N$.
Para calcularlo utilizamos el algoritmo de Euclides.
:::

:::{.theorem #thm:probabilidad}
Sea $N$ un entero compuesto impar positivo con más de un factor.
Sea $x \in U(\mathbb{Z}_N)$ elegido aleatoriamente de forma uniforme, $r = \operatorname{ord}(x)$.
Entonces
$$P[r \text{ es par y } x^{r/2} \neq -1 \mod N] > \frac{1}{2}$$
:::
:::{.proof}
Si $N$ se descompone como $N = \prod_1^M p_i^{e_i}$ entonces
$$U(\mathbb{Z}_N) \simeq \prod_{i = 1}^M U(\mathbb{Z}_{p_i^{e_i}}), \text{ con el isomorfismo } x \mapsto (x \!\!\!\mod p_i^{e_i})_{i = 1, \dots, N},$$
por el teorema chino del resto, luego tomar $x \in U(\mathbb{Z}_N)$ uniformemente es equivalente a tomar $x_i \in U(\mathbb{Z}_{p_i^{e_i}})$ uniformemente.

Sea $r_i = \operatorname{ord}(x_j)$ y $2^{d_i}$ la máxima potencia de 2 que divide a $r_i$, $2^d$ la máxima potencia de 2 que divide a $r$.

::::{.claim}
Si $r$ es impar o $x^{r/2} = -1 \mod N$ para todo $i,j$ se tiene que $d_i = d_j$.
::::

En efecto, supongamos que $r$ es impar. Entonces, como $r_i | r$ para todo $i$ tenemos que $d_i = 0$ para todo $i$.
Por otra parte, si $r$ es par y $x^{r/2} = -1 \mod N$ tenemos que, para todo $i$,
$$x^{r/2} = -1 \mod p_i^{e_i} \implies r_i \not | (r/2) \implies  d_i = d \,\forall i,$$
donde en la segunda implicación hemos usado que $r_i | r$.

::::{.claim}
Sea $2^{d'_i}$ la mayor potencia de 2 que divide a $\varphi(p_i^{e_i})$.
Entonces $P[2^{d'_i} | r_i] = 1/2$.
::::
Sabemos que $U(\mathbb{Z}_{p_i^{e_i}}) \simeq C_{\varphi(p_i^{e_i})} \simeq \langle g \rangle$, luego $x_i = g^k$ para cierto $k$.

Si $k$ es impar entonces $r_i$ es par, luego, como $\varphi(p_i^{e^i}) | kr_i$, tenemos que $2^d | r_i$.
Si $k$ es par entonces podemos ver que $r_i | \varphi(p_i^{e_i})$, luego $2^d \not | r_i$.

Por tanto, usando ambas afirmaciones tenemos que la probabilidad de que $r$ sea impar o $x^{r/2} = -1 \mod N$ es menor o igual a $\frac{1}{2^m} < \frac{1}{4}$, lo que prueba el resultado.
:::

A partir de estos teoremas queda justificado el algoritmo de Shor:

:::{.algorithm name='Algoritmo de Shor'}

$\;$

Entrada
: Un entero compuesto $N$

Salida
: Un factor no trivial de $N$

Tiempo de ejecución
: $O(\log^3 N)$

#. Si $N$ es par, **devuelve** $2$
#. \label{paso:ab} Si $N = a^b$ para $a \geq 1$, $b \geq 2$, **devuelve** $a$.
#. Elige $x$ uniformemente de $\mathbb{Z}_N\backslash\{0\}$.
#. \label{paso:cuant} Si $\gcd(x,N) > 1$: **devuelve** $\gcd(x,N)$.
   En otro caso, halla $r := \operatorname{ord}(r,N)$.
#. Si $r$ es par y $x^{r/2} \neq -1 \mod N$ **devuelve** $\gcd(x^{r/2}-1,N)$. En otro caso **falla**.
:::

Para justificar el algoritmo notamos que:

1. El [@paso:ab] es calculable en tiempo $O(\log^3 N)$ mediante *exponenciación binaria*.
2. En [@paso:cuant] utilizamos el [@lemma:orden] para obtener el orden.
   Se conjetura que este paso no es calculable en tiempo polinomial clásico, justificando el uso del algoritmo cuántico.
3. La corrección del algoritmo en el último paso viene justificada por [@thm:divisores].
4. La probabilidad de fallo viene dada por [@thm:probabilidad] que nos da error acotado.

Todos los pasos son calculables en tiempo polinomial cuántico, luego el algoritmo es calculable en tiempo polinomial cuántico. Si queremos obtener todos los factores sólo tenemos que aplicar recursivamente el algoritmo con el factor obtenido $c$ y con $N/c$.
