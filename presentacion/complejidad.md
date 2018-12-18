# Complejidad asintótica

## Algunas definiciones previas

:::{.definition name='Notación O-grande'}

Sea $T : \mathbb{N} \to \mathbb{N}$,

$T(n)\text{ es }O(f(n)) \Leftrightarrow \exists c \in \mathbb{R}, \exists n_0 \in \mathbb{N}\text{, t.q. }\forall n \geq n_0, T(n) \leq c f(n)$
:::

:::{.definition name='Calculabilidad'}
Sea $f: \{0,1\}^\ast \to \{0,1\}^\ast$, $T: \mathbb{N} \to \mathbb{N}$.
Un algoritmo (clásico) *calcula $f$ en tiempo* $O(T(n))$ si, la función que asocia a cada $n$ el máximo número de pasos que toma el algoritmo para calcular $f(x)$ con $|x| = n$ es $O(T(n))$.

Un algoritmo (clásico) *calcula $f$ en tiempo polinómico (clásico)* si lo calcula en tiempo $O(T(n))$ con $T$ un polinomio.
:::


## ¿Cómo se pueden representar polinomios?

- Representación mediante sus coeficientes  
- Representación por parejas punto-valor (un punto y su evaluación)

**Cada representación favorece computacionalmente distintas operaciones**

## Representación mediante coeficientes

$\text{Dado un polinomio }A(x) = \sum_{j=0}^{n-1} a_j x^j \text{ de grado menor que } n$ $\text{ su representación por coeficientes es}$

$$a=(a_0,a_1,\dots,a_{n-1})$$

### Operaciones favorecidas

- Evaluación (algoritmo de Horner, calculándose en un tiempo de $O(n)$).  
- Suma de polinomios ($O(n)$)

$a=(a_0,\dots,a_{n-1}),b=(b_0,\dots,b_{n-1}) \Rightarrow c = (c_0,\dots,c_{n-1}): c_j = a_j+b_j$

### Operaciones más costosas

- Multiplicación de polinomios (convolución de sus coeficientes, $O(n^2)$)

## Representación por parejas punto-valor

La representación punto valor de un polinomio $A(x), \deg(A) \leq n$ es un conjunto de n pares punto-valor

$$\{(x_0,y_0),(x_1,y_1),\dots,(x_{n-1},y_{n-1})\}$$

de forma que cada $x_k$ es distinto y $y_k = A(x_k)$ para  $k=0,\dots,n-1$

### Cálculo de la Representación

- Basta con seleccionar $n$ puntos distintos $x_0,x_1,\dots,x_{n-1}$ y evaluarlos en $A(x)$.
  - Algoritmo de Horner ($O(n^2)$)
  - Eligiendo cuidadosamente los $x_k$ se reduce a **$O(n \log n)$**

## Representación por parejas punto-valor

Determinar los coeficientes de un polinomio dado en su representación punto-valor es un proceso llamado **interpolación**.

:::{.theorem #thm:interpolación}
Para todo conjunto $\{(x_0,y_0),\dots,(x_{n-1},y_{n-1})\}$ de $n$ parejas punto-valor con $x_k$ distintos para todo $k$, existe un único polinomio $$A(x), \deg(A) \leq n  : y_k = A(x_k) \qquad \forall k = 0,\dots,n-1$$
:::

## Representación por parejas punto-valor

### Operaciones favorecidas

- Suma y multiplicación de polinomios ($O(n)$)

**Precaución:**
Si $A,B$ son polinomios de grado menor o igual que n y $C=A+B$, entonces $\deg(C)= \deg(A) + \deg(B) \Rightarrow \deg(C) \leq 2n$  
$\Rightarrow$ Para aplicar el teorema anterior se necesitan $\textbf{2n}$ nodos que interpolar...  
$$\centering{\Rightarrow \textbf{Representación punto-valor extendida}}$$

## Multiplicación rápida de polinomios en forma de coeficientes

¿Es posible utilizar el método de multiplicación de polinomios en su forma punto-valor (tiempo lineal) para acelerar la multiplicación a través de los coeficientes? $\Leftrightarrow$ **Evaluar e interpolar polinomios rápidamente.**
