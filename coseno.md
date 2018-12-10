# La transformada discreta del coseno

Esta sección presenta una familia de variantes de la transformada de Fourier discreta que tienen por dominio e imagen secuencias o vectores de números reales, y describe a grandes rasgos su uso e interés en el diseño de algoritmos de compresión para imágenes y grabaciones de sonido.

## Archivos multimedia

Desde tiempos remotos, el ser humano ha tenido la necesidad de representar imágenes y sonidos a través de distintas técnicas como la pintura, la notación musical, la fotografía o la grabación de sonido. Con el desarrollo de los ordenadores digitales, que permiten administrar información en forma de secuencias finitas de dígitos binarios o **bits**, surgió una nueva forma de almacenar sonidos e imágenes: los archivos multimedia.

Para obtener un archivo multimedia que codifique una imagen o un sonido, el procedimiento habitual se basa en muestrear y cuantizar su señal analógica asociada, medida mediante un instrumento mecánico o electromagnético. El muestreo consiste en medir un conjunto finito de valores relacionados con el fenómeno en cuestión: en caso de una imagen, se mide la intensidad de la luz en distintos puntos de la misma; en el sonido, la presión atmosférica en varios instantes. La cuantización asigna, para cada medida tomada, un valor en un conjunto finito, redondeando los valores medidos. De esta forma, estos fenómenos quedan registrados como un conjunto finito de dígitos que representan una versión aproximada de los mismos. Para recrear la imagen o el sonido se genera un fenómeno físico cuya señal analógica asociada se aproxime a la información digital almacenada, de forma que se genera una aproximación de la imagen o el sonido original.

En general el muestreo se produce a intervalos regulares: leyendo la presión atmosférica cada cierto tiempo en el caso del sonido o registrando las intensidades luminosas en los puntos de una rejilla sobre una imagen. El inverso de la longitud del intervalo temporal que separa muestras consecutivas se denomina **frecuencia de muestreo**, y la tupla de las dimensiones de la rejilla se llama **resolución**. La cuantización determina un subconjunto finito de números enteros que se pueden asignar a cada valor medido, y normalmente se elige el conjunto de números $\{0,\, 1,\, \dots,\, 2^N - 1\}$ o el conjunto de números $\{-2^{N-1},\, -2^{N-1} + 1,\, \dots,\, -1,\, 0,\, 1,\, \dots,\, 2^N - 2\}$, con $N \in \mathbb N$, donde los valores son aproximadamente proporcionales a la intensidad medida (o a alguna transformación monótona de la misma, como la raíz cuadrada o el logaritmo). Ambos conjuntos tienen $2^N$ elementos, por lo que el valor de cada muestra se puede codificar con $N$ bits; en cuyo caso se denomina **profundidad de bits** al número $N$.

El formato de almacenamiento en bruto consiste en registrar el valor medido en cada muestra siguiendo algún orden canónico. Por ejemplo, dado un archivo de sonido en bruto, los primeros $N$ bits habitualmente representan la presión en el primer instante medido. Si un archivo contiene $M$ muestras medidas a una profundidad de bits de $N$, entonces el número de bits requeridos para almacenar el archivo es $N \cdot M$. De esta forma, según la frecuencia de muestreo (que es inversamente proporcional a $M$) o la resolución (el producto de sus dos valores es $M$) y según la profundidad de bits se tendrá un archivo de mayor o menor tamaño, que representará con menor o mayor fidelidad el fenómeno grabado. Sin embargo, la fidelidad es muy sensible a estos valores, por lo que en los archivos de sonido no es habitual que la frecuencia de muestreo sea inferior a $44\,100 Hz$ o que la profundidad de bits sea menor de $16$, y las imágenes fotográficas suelen tener una profundidad de bits de $24$ y una resolución cada vez mayor.

Los formatos de archivo multimedia más básicos almacenan entre otras cosas la profundidad de bits y la frecuencia de muestreo o la resolución en el inicio del archivo, y a continuación los datos en bruto. Para la mayoría de aplicaciones, estos formatos no resultan prácticos, pues los archivos ocupan un espacio excesivo. Ante este problema surgió la necesidad de obtener algoritmos de compresión multimedia, con el que poder obtener archivos de tamaño más manejable.

Un método para reducir el tamaño de los archivos es aplicar algoritmos de compresión sin pérdida de secuencias de bits genéricas, que eliminan la redundancia de la información de los archivos, de forma que se puede reconstruir el archivo digital original. Entre estos algoritmos están los métodos estadísticos, que en vez de almacenar los valores de cada muestra en un número fijo de bits intentan representar con menos bits los valores más comunes, y los métodos de diccionario, que almacenan en un diccionario secuencias de valores consecutivos comunes y, cuando estas aparecen, en lugar de reproducirlas escriben una referencia al diccionario. Sin embargo, estos procedimientos tienen un éxito discreto en las grabaciones de sonido y en las imágenes fotográficas, pues los valores medidos suelen seguir una distribución aproximadamente uniforme a lo largo de todo el rango de valores, y las ocurrencias de secuencias exactas de valores son poco frecuentes [@nelson1996data].

En contraposición a los algoritmos de compresión sin pérdida de secuencias de bits se tienen los algoritmos de compresión que aplican conocimiento experto sobre la secuencia de bits que reciben. Estos algoritmos aprovechan propiedades de las secuencias de bits de un tipo concreto para obtener, mediante una transformación invertible, una secuencia de menor longitud, consiguiendo así comprimir el archivo original, que se puede obtener aplicando la transformación inversa. La secuencia transformada se puede tratar de comprimir más con algoritmos como los expuestos en el apartado anterior, como se hace en el formato de imagen PNG y en el formato de sonido FLAC. Si se descarta parte de la secuencia transformada de forma que la parte que se almacene dé lugar a una versión razonablemente aproximada del archivo multimedia original, se puede obtener una compresión mayor: esto es lo que hacen los algoritmos de compresión con pérdida.

Un enfoque común a la hora de aplicar conocimiento experto al almacenamiento de archivos multimedia consiste en tratar la imagen o la grabación (o bloques de las mismas) como una combinación lineal de ondas básicas, almacenando los coeficientes de dicha combinación lineal en lugar de los valores en cada muestra. En esta situación es común almacenar solo los coeficientes de las ondas que las componen que se consideren adecuadas para representar el contenido multimedia con suficiente fidelidad. Para ello, dado que la información que tiene el ordenador es la representación digital de la imagen o el sonido, se puede utilizar una operación semejante a la transformada de Fourier discreta que trabaje con tuplas de números de un conjunto ordenado y finito, como puede ser un subconjunto finito de los números reales.

## Generalización de la transformada de Fourier discreta

La transformada de Fourier discreta se puede ver como un caso particular de las transformaciones [@oppenheim1999discrete] $\mathcal A : \mathbb C^N \to \mathbb C^N$ definidas para cada $\{x\} = x_0,\,\dots,\,x_{N-1}$ como $\mathcal A\{x\} = X_0,\,\dots,\,X_{N-1}$ donde $$X_k = \sum_{n=0}^{N-1} x_n \phi^*_k(n) \quad \forall k \in \{0,\,\dots\,N-1\}$$ para algunas $\phi^*_k : \{0,\,\dots,\,N-1\} \to \mathbb C$ de forma que para cada $k \in \{0,\,\dots\,N - 1\}$ existe $\phi_k : \{0,\,\dots,\,N-1\} \to \mathbb C$ de forma que para cada $n,\,m$ se tenga que $$\frac 1 N \sum_{k=0}^{N-1} \phi_n(k) \phi^*_m(k) = \left\{ \begin{array}{ccc} 1 & \text{si} & m = n \\ 0 & \text{si} & m \neq n \end{array} \right.$$

Se observa que, si se llama $\Phi$ a la matriz que en la fila $k$ y la columna $n$ contiene el número $\phi_k(n)$ y $\Phi^*$ a la matriz que en la fila $k$ y la columna $n$ contiene el número $\phi^*_k(n)$, entonces las matrices tienen por filas las componentes de $\phi_k$ y $\phi^*_k$ respectivamente, $\mathcal A\{x\}$ puede obtenerse como el producto matricial $\Phi^* x$ y la propiedad queda como que $\Phi^T \Phi^* = N I_{N \times N}$ con $I_{N \times N}$ la matriz identidad. De esta forma, la propiedad expresa relaciones entre cada pareja de vectores $\phi_n$ y $\phi^*_m$. A los vectores $\phi_k$ y $\phi^*_k$ se les llamará **secuencias base**, y esta propiedad que se le exige a las secuencias base se llamará **relaciones de ortogonalidad** aunque no vaya necesariamente ligada a un producto escalar, cosa que ocurriría si se pudiese asociar $\phi^*_k(n)$ con $\phi_k(n)$ a través de una aplicación semilinal $\cdot ^* : \mathbb R \to \mathbb R$ con la cual $\displaystyle (x,\, y) \mapsto \frac 1 N \sum_{k=0}^{N-1} x_k y_k^*$ fuese una forma sesquilineal definida positiva.

Asumiendo que las secuencias base $\phi_k,\, \phi^*_k$ cumplen estas relaciones de ortogonalidad, se cumple que $\Phi^T \Phi^* = N I_{N \times N}$, y por tanto para toda secuencia $x = (x_0,\,\dots\,x_{N-1})^T$ ocurrirá que $\Phi^T \Phi^* x = N x$; es decir, que $x$ se puede reconstruir como $\frac 1 N \Phi^T \mathcal A\{x\}$, o componente a componente: $$x_n = \frac 1 N \sum_{k=0}^{N-1} X_k \phi_k(n) \quad \forall k \in \{0,\,\dots\,N-1\}$$

y por tanto la transformación $\mathcal A$ tiene inversa (en particular, es un automorfismo). Obsérvese que el caso de la transformada de Fourier discreta es aquel en el que $\phi_k(n) = e^{\frac {2 \pi i k n} N}$ y $\phi^*_k(n) = e^{\frac {-2 \pi i k n} N}$, en cuyo caso $\phi^*_k(n)$ es el conjugado complejo de $\phi_k(n)$ y las relaciones de ortogonalidad son las determinadas por el producto escalar en $\mathbb C^N$.

En general, la información discreta que se almacena en cada muestra de una imagen o un sonido suele tomar un valor en un conjunto ordenado, que se puede interpretar como un subconjunto de $\mathbb R$. Por ello, dado que la transformada de Fourier discreta puede llevar secuencias de números reales en secuencias de números complejos, interesa buscar una transformada discreta dentro de las secuencias de números reales, $\mathcal R: \mathbb R^N \to \mathbb R^N$.

Para obtener una transformada de este tipo no basta tomar parte real en $\phi_k$ y $\phi^*_k$. En este caso, se obtiene $\phi_k(n) = \cos(\frac {2 \pi k n} N)$ y $\phi_k^*(n) = \cos(\frac {-2 \pi k n} N)$. Estas funciones no mantienen la relación de ortogonalidad, puesto que $\phi_k^*(n) = \phi_k^*(N - n)$ debido a la paridad y periodicidad del coseno, y por tanto si fuese cierto que $\frac 1 N \sum_{k=0}^{N-1} \phi_k(n) \phi^*_k(n) = 1$ para todo $n$ entonces también se tendría que $\frac 1 N \sum_{k=0}^{N-1} \phi_k(n) \phi^*_k(N - n) = 1$ para todo $n$, incluyendo aquellos tales que $n \neq N - n$.

En el estándar de imágenes JPEG y diversos estándares de archivos de sonido se usan distintas transformadas discretas, que se obtienen eligiendo distintas secuencias base $\phi_k,\, \phi^*_k$ que estén formadas por números reales y que cumplan las relaciones de ortogonalidad. Estas secuencias se derivan interpretando la secuencia de entrada como parte de una secuencia mayor, extendiéndola de forma periódica y par [@oppenheim1999discrete]. Así, al aplicar la transformada de Fourier discreta sobre la extensión de la secuencia, se anulan las partes imaginarias y el resultado es un vector de números reales. Para no trabajar con números complejos, se toma la parte real en los coeficientes de las secuencias base, de forma que finalmente quedan como cosenos, dando lugar a distintos casos (según cómo se realice la extensión de la secuencia) de **transformada discreta del coseno**, o **DCT**, por _Discrete Cosine Transform_.

## Distintas versiones de la transformada discreta del coseno

Dada una secuencia $\{x\} = x_0,\,\dots,\,x_{N-1}$, hay distintas opciones de extenderla de forma simétrica y par, según dónde se tomen los puntos de simetría y según si en primer lugar se hace una extensión impar. Cuatro de ellas son:

1. Simetría par respecto de $0$ y $N-1$ (período $2N - 2$): $$\{\tilde x\}_1 := \dots x_2,\, x_1,\, \underbrace{x_0,\,x_1,\,\dots,\,x_{N-2},\,x_{N-1}}_{\{x\}},\,x_{N-2},\,x_{N-3},\,\dots,\,x_1,\,\underbrace{x_0,\,x_1,\,\dots}_{\{x\}}$$
2. Simetría par respecto de $-\frac 1 2$ y $N - \frac 1 2$ (período $2N$): $$\{\tilde x\}_2 := \dots x_1,\, x_0,\, \underbrace{x_0,\,x_1,\,\dots,\,x_{N-2},\,x_{N-1}}_{\{x\}},\,x_{N-1},\,x_{N-2},\,\dots,\,x_1,\,\underbrace{x_0,\,x_1,\,\dots}_{\{x\}}$$
3. Extensión impar respecto de $N$ y simetría par respecto de $0$ y $2N$ (período $4N$): $$\{\tilde x\}_3 := \dots x_2,\, x_1,\, \underbrace{x_0,\,x_1,\,\dots,\,x_{N-2},\,x_{N-1}}_{\{x\}},\,0,\,-x_{N-1},\,-x_{N-2},$$ $$\dots,\,-x_1,\,\underbrace{-x_0,\,-x_1,\,\dots,\,-x_{N-2},\,-x_{N-1}}_{-\{x\}},\,0,\,x_{N-1},\,\dots,\,x_1,\,\underbrace{x_0,\,x_1,\,\dots}_{\{x\}}$$
4. Extensión impar respecto de $N - \frac 1 2$ y simetría par respecto de $-\frac 1 2$ y $2N - \frac 1 2$ (período $4N$): $$\{\tilde x\}_4 := \dots x_2,\, x_1,\, \underbrace{x_0,\,x_1,\,\dots,\,x_{N-2},\,x_{N-1}}_{\{x\}},\,-x_{N-1},\,-x_{N-2},$$ $$\dots,\,-x_1,\,-x_0,\,\underbrace{-x_0,\,-x_1,\,\dots,\,-x_{N-2},\,-x_{N-1}}_{-\{x\}},\,x_{N-1},\,\dots,\,x_1,\,x_0,\,\underbrace{x_0,\,x_1,\,\dots}_{\{x\}}$$

<div id="fig:extensiones">

![Extensión 1](imgs/extension1.pdf){width=50%}
![Extensión 2](imgs/extension2.pdf){width=50%}

![Extensión 3](imgs/extension3.pdf){width=50%}
![Extensión 4](imgs/extension4.pdf){width=50%}

Extensiones pares consideradas. Los cuatro puntos marcados se corresponden con los de la secuencia original.
</div>

De estas secuencias extendidas obtenemos $N$ coeficientes de su transformada de Fourier discreta. La paridad y periodicidad de las extensiones producirán coeficientes pares si la transformada está alineada con la extensión; para ello, como las extensiones $2$ y $4$ tienen simetría par respecto de $-\frac 1 2$, hay que aplicar la transformada desplazada $-\frac 1 2$ en las extensiones $2$ y $4$. Según el teorema de desplazamiento ([@prop:despcircular]) de la transformada de Fourier discreta, $$\mathcal{F}(\operatorname{shift}_h\{x\})=\{X\} \{W_N^{-hk}\}_{0 \leq k < N}$$ con el producto componente a componente; y por tanto, cuando $h = - \frac 1 2$, la componente $k$-ésima se multiplica por $W_N^{\frac k 2} = e^{\frac {-\pi i k} N}$ (con $N$ dado por la longitud de la secuencia extendida, no de la original), y por ello hay que sustituir $n$ por $n + \frac 1 2$ (o equivalentemente, por $2n + 1$ y multiplicar por $2$ el denominador), pues $$e^{\frac{-2 \pi i k (n + \frac 1 2)}N} = e^{\frac{-2 \pi i k n}N} e^{\frac{-\pi i k}N}$$

De las transformadas de las extensiones $1$ y $2$ tomamos los $N$ primeros coeficientes. En el caso de las extensiones $3$ y $4$, dado que introducen una extensión impar (seguida de una par, que da lugar a un período de longitud $4N$), los coeficientes de las transformadas en las posiciones pares toman el valor $0$, dado que cuando $k$ es par $e^{\frac{-2 \pi i k n}{4N}}$ oscila un número entero de veces cada $2N$ muestras, puesto que, si $n$ es múltiplo de $2N$ y $k$ es par, $e^{\frac{- \pi i \frac k 2 n}N} = 1$. Por ello, en cada semiperíodo de la secuencia extendida (es decir, cada subsecuencia de $2N$ muestras) se anulan los coeficientes. Por ello, en las extensiones $3$ y $4$ se toman los $N$ primeros coeficientes en posiciones impares, es decir, aquellos de la forma $2k + 1$ con $k \in \{0,\,\dots\,N-1\}$.

Sabiendo esto, aplicamos la transformada de Fourier discreta a la secuencia extendida para cada $k \in \{0,\, \dots \, N-1\}$:

$$(\mathcal F\{\tilde x\}_1)_k = \sum_{n=0}^{2N - 3} (\tilde x_1)_n e^{\frac{-2 \pi i k n}{2N - 2}} = x_0 e^0 + \sum_{n=1}^{N - 2} x_n e^{\frac{-\pi i k n}{N - 1}} + x_{N-1} e^{\frac{-\pi i k (N-1)}{N - 1}} + \sum_{n=1}^{N - 2} x_n \underbrace{e^{\frac{-\pi i k (2N - 2 - n)}{N - 1}}}_{e^{\frac{+\pi i k n}{N - 1}}}$$ $$ = x_0 + 2\sum_{n=1}^{N - 2} x_n Re\ e^{\frac{-\pi i k n}{N - 1}} + x_{N-1} e^{-\pi i k} = x_0 + 2 \sum_{n=1}^{N-2} x_n \cos\left(\frac{\pi k n}{N - 1}\right) + (-1)^k x_{N-1}$$

$$(\mathcal F\{\tilde x\}_2)_k = \sum_{n=0}^{2N - 1} (\tilde x_2)_n e^{\frac{-2 \pi i k (n + \frac 1 2)}{2N}} = \sum_{n=0}^{N-1} x_n e^{\frac{-2 \pi i k (n + \frac 1 2)}{2N}} + \sum_{n=0}^{N-1} x_n \underbrace{e^{\frac{-2 \pi i k (2N - n - \frac 1 2)}{2N}}}_{e^{\frac{+2\pi i k (n + \frac 1 2)}{2N}}}$$ $$ = 2 \sum_{n=0}^{N-1} x_n Re\ e^{\frac{-2 \pi i k (n + \frac 1 2)}{2N}} = 2 \sum_{n=0}^{N-1} x_n \cos\left(\frac{\pi k (n + \frac 1 2)}{N}\right)$$

$$(\mathcal F\{\tilde x\}_3)_k = \sum_{n=0}^{4N - 1} (\tilde x_3)_n e^{\frac{-2 \pi i (2k + 1) n}{4N}} = x_0 e^0 + \sum_{n=1}^{N-1} x_n e^{\frac{- \pi i (2k + 1) n}{2N}} + 0 - \sum_{n=1}^{N-1} x_n \underbrace{e^{\frac{- \pi i (2k + 1) (2N - n)}{2N}}}_{-e^{\frac{+ \pi i (2k + 1) n}{2N}}} $$ $$ - x_0 e^{\frac{- \pi i (2k + 1) (2N)}{2N}} - \sum_{n=1}^{N-1} x_n \underbrace{e^{\frac{- \pi i (2k + 1) (2N + n)}{2N}}}_{-e^{\frac{+ \pi i (2k + 1)(4N - n)}{2N}}} + 0 + \sum_{n=1}^{N-1} x_n e^{\frac{- \pi i (2k + 1) (4N - n)}{2N}} = 2 x_0 $$ $$ + 2 \sum_{n=1}^{N-1} x_n Re\ e^{\frac{- \pi i (2k + 1) n}{2N}} + 2 \sum_{n=1}^{N-1} x_n Re\ e^{\frac{- \pi i (2k + 1) (4N - n)}{2N}} = 2 x_0 + 4 \sum_{n=1}^{N-1} x_n \cos \left(\frac{\pi (2k + 1) n}{2N}\right)$$

$$(\mathcal F\{\tilde x\}_4)_k = \sum_{n=0}^{4N - 1} (\tilde x_4)_n e^{\frac{-2 \pi i (2k + 1) (2n + 1)}{8N}} = \sum_{n=0}^{N-1} x_n e^{\frac{- \pi i (2k + 1) (2n + 1)}{4N}} - \sum_{n=0}^{N-1} x_n \underbrace{e^{\frac{- \pi i (2k + 1) (2N - 2n - 1)}{4N}}}_{-e^{\frac{+ \pi i (2k + 1)(2n + 1)}{4N}}} $$ $$ - \sum_{n=0}^{N-1} x_n \underbrace{e^{\frac{- \pi i (2k + 1) (2N + 2n + 1)}{4N}}}_{-e^{\frac{+ \pi i (2k + 1) (4N - 2n - 1)}{4N}}} + \sum_{n=0}^{N-1} x_n e^{\frac{- \pi i (2k + 1) (4N - 2n - 1)}{4N}} = 2 \sum_{n=0}^{N-1} x_n Re\ e^{\frac{- \pi i (2k + 1)(2n + 1)}{4N}} $$ $$ + 2 \sum_{n=0}^{N-1} x_n Re\ e^{\frac{- \pi i (2k + 1)(4N - 2n - 1)}{4N}} = 4 \sum_{n=0}^{N-1} x_n \cos\left(\frac{\pi (2k + 1) (2n + 1)}{4N}\right)$$


Se tienen así, tras multiplicar por constantes e incluir los sumandos en los sumatorios, cuatro transformadas discretas del coseno:

 - $\displaystyle \textbf{DCT-I}\{x\}_k = \sum_{n=0}^{N-1} \alpha_n x_n \cos\left(\frac{\pi k n}{N - 1}\right)$ donde $\alpha_0 = \alpha_{N-1} = \frac 1 2$, $\alpha_i = 1$ en otro caso
 - $\displaystyle \textbf{DCT-II}\{x\}_k = \sum_{n=0}^{N-1} x_n \cos\left(\frac{\pi k (n + \frac 1 2)}{N}\right)$
 - $\displaystyle \textbf{DCT-III}\{x\}_k = \sum_{n=0}^{N-1} \beta_n x_n \cos\left(\frac{\pi (k + \frac 1 2) n}{N}\right)$ donde $\beta_0 = \frac 1 2$, $\beta_i = 1$ en otro caso
 - $\displaystyle \textbf{DCT-IV}\{x\}_k = \sum_{n=0}^{N-1} x_n \cos\left(\frac{\pi (k + \frac 1 2) (n + \frac 1 2)}{N}\right)$

También se suelen presentar en su forma normalizada, en la que dan lugar a una matriz de coeficientes unitaria:

 - $\displaystyle \textbf{NDCT-I}\{x\}_k = \sqrt{\frac 2 {N-1}} \gamma_k \sum_{n=0}^{N-1} \gamma_n x_n \cos\left(\frac{\pi k n}{N - 1}\right)$ donde $\gamma_0 = \gamma_{N-1} = \frac 1 {\sqrt 2}$, $\gamma_i = 1$ en otro caso
 - $\displaystyle \textbf{NDCT-II}\{x\}_k = \sqrt {\frac 2 N} \delta_k \sum_{n=0}^{N-1} x_n \cos\left(\frac{\pi k (n + \frac 1 2)}{N}\right)$ donde $\delta_0 = \frac 1 {\sqrt 2}$, $\delta_i = 1$ en otro caso
 - $\displaystyle \textbf{NDCT-III}\{x\}_k = \sqrt {\frac 2 N} \sum_{n=0}^{N-1} \delta_n x_n \cos\left(\frac{\pi (k + \frac 1 2) n}{N}\right)$ donde $\delta_0 = \frac 1 {\sqrt 2}$, $\delta_i = 1$ en otro caso
 - $\displaystyle \textbf{NDCT-IV}\{x\}_k = \sqrt {\frac 2 N} \sum_{n=0}^{N-1} x_n \cos\left(\frac{\pi (k + \frac 1 2) (n + \frac 1 2)}{N}\right)$


Se cumple que la DCT-II y la DCT-III son inversas entre ellas (en el caso no normalizado, salvo constante de normalización), puesto que cumplen las relaciones de ortogonalidad con $\phi^*_k(n) = \cos\left(\frac{\pi k (n + \frac 1 2)}{N}\right)$ y $\phi_k(n) = \beta_n \cos\left(\frac{\pi (k + \frac 1 2) n}{N}\right)$. Alternativamente, se puede ver que las matrices de las formas normalizadas son transpuestas entre ellas [@rao1990dct].

Como los $\phi_k^*$ dados por las versiones normalizadas de las transformadas conforman un sistema ortonormal, se tiene una identidad de Parseval para cada DCT.

## La transformada discreta del coseno estándar (DCT-II)

En la mayoría de aplicaciones se usa una transformada discreta del coseno concreta: la conocida como **DCT-II**. En ausencia de contexto, el término _transformada discreta del coseno_ hace referencia a esta transformada.

Para cualesquiera $\{x\} = x_0,\,\dots\,x_{N-1},\,\{y\} = y_0,\,\dots\,y_{N-1}$ secuencias de números reales, se cumple la siguiente identidad de Parseval:

$$\langle \{x\},\,\{y\} \rangle = \sum_{k=0}^{N-1} x_k y_k = \sum_{k=0}^{N-1} (\text{NDCT-II}\{x\})_k (\text{NDCT-II}\{y\})_k $$ $$= \sum_{k=0}^{N-1} \left(\sqrt {\frac 2 N} \delta_k \right)^2 (\text{DCT-II}\{x\})_k (\text{DCT-II}\{y\})_k = \frac 2 N \sum_{k=0}^{N-1} \beta_k (\text{DCT-II}\{x\})_k (\text{DCT-II}\{y\})_k$$

donde $\beta_0 = \frac 1 2$, $\beta_i = 1$ en otro caso ($\delta_0 = \frac 1 {\sqrt 2}$, $\delta_i = 1$ en otro caso). De ello se deduce esta identidad de Plancherel:

$$\|\{x\}\|_2^2 = \langle \{x\},\,\{x\} \rangle = \frac 2 N \sum_{k=0}^{N-1} \beta_k (\text{DCT-II}\{x\})_k^2$$

En procesamiento de señales, dada una secuencia de números reales $\{x\} = x_0,\,\dots\,x_{N-1}$, se define su **energía** como $E_{\{x\}} = \|\{x\}\|_2^2$. Este concepto es análogo al de energía de una señal continua $f$, definida $E_f = \int_{-\infty}^\infty (f(t))^2\, dt$. La identidad de Plancherel implica que el valor absoluto de cada coeficiente de la transformada de una secuencia contribuye a la energía de la secuencia.

Dada una secuencia $\{x\}$, se puede considerar la diferencia de energía entre $\{x\}$ y la transformada inversa de la secuencia que se obtiene al anular los $m$ últimos elementos de la transformada de $\{x\}$, es decir, el error cuadrático medio de aproximación. Según se detalla en [@rao1990dct], la DCT-II es casi óptima en este sentido; es decir, permite reconstruir la secuencia original a partir de los primeros términos de la transformada con un error relativamente bajo. Esta propiedad, conocida como **propiedad de compactación de energía**, es la que hace que la DCT-II resulte de especial utilidad en diversos algoritmos de compresión.

## Formato de imagen JPEG

El estándar JPEG (cuyo nombre procede de _Joint Photographic Experts Group_) describe un algoritmo de compresión con pérdida de imágenes en color o en escala de grises muy popular que se basa en la DCT-II normalizada bidimensional, que es la siguiente [@salomon2007data] [@nelson1996data], con $p$ una matriz de números reales de dimensiones $N \times N$:

$$X_{ij} = \frac {\alpha_i \alpha_j} {\sqrt{2 N}} \sum_{x = 0}^{N-1} \sum_{y = 0}^{N-1} p_{xy} \cos\left(\frac{i \pi (2x + 1)}{2N}\right) \cos\left(\frac{j \pi (2y + 1)}{2N}\right) \quad \forall i,j \in \{0,\,\dots,\,N-1 \}$$

donde $\alpha_k = 1$ si $k > 0$ y $\alpha_0 = \frac 1 {\sqrt 2}$. La operación se puede invertir aplicando la DCT-III normalizada:

$$p_{xy} = \sqrt{2 N} \sum_{i = 0}^{N-1}  \sum_{j = 0}^{N-1} \alpha_i \alpha_j X_{ij} \cos\left(\frac{i \pi (2x + 1)}{2N}\right) \cos\left(\frac{j \pi (2y + 1)}{2N}\right) \quad \forall i,j \in \{0,\,\dots,\,N-1 \}$$

Una imagen digital en formato bruto se pasa al formato JPEG con un procedimiento como el siguiente [@salomon2007data]:

 - Si la imagen está en color, se pasa al espacio de color YCbCr, se submuestrean los canales de crominancia y el resto del algoritmo se aplica a cada uno de los canales por separado.
 - Los píxeles se agrupan en cuadrados de tamaño $8 \times 8$. En cada uno de ellos:
   - Se aplica la DCT-II bidimensional (con $N = 8$), obteniendo una matriz de intensidades de frecuencias de tamaño $8 \times 8$.
   - La matriz de intensidades de frecuencias se divide componente a componente por una **matriz de cuantización** del mismo tamaño, redondeando el resultado en cada componente al entero más cercano.
   - Se comprime la matriz resultante usando técnicas de compresión sin pérdida.
 - Se escribe una cabecera de archivo con la matriz de cuantización y las dimensiones de la imagen entre otros datos, y a continuación se escriben las matrices comprimidas.

Para obtener la imagen original, cada matriz de intensidades de frecuencias se multiplica por la misma matriz de cuantización y a continuación se aplica la transformada inversa, que es la DCT-III. Después se agrupan los cuadrados de tamaño $8 \times 8$ para obtener la imagen original haciendo la conversión de espacio de color desde YCbCr al que se desee.

Un espacio de color es una forma de interpretar cada punto de $[0,\,1]^3$ como un color. Por ejemplo, el espacio de color RGB asigna a cada tupla el color dado por la combinación lineal de intensidades de rojo, verde y azul cuyos coeficientes son las componentes de la tupla. El espacio de color YCbCr asigna una intensidad luminosa proporcional al primer elemento de la tupla, y los otros dos determinan la cantidad de rojo o azul que toma el píxel (donde el resto de luminosidad será asignada al color verde). De esta forma la imagen se agrupa en tres canales: uno llamado canal de luminancia (Y), que se corresponde con los primeros elementos de cada tupla, y dos canales de crominancia (Cb, Cr).

El submuestreo de una imagen consiste en la obtención de una imagen de resolución inferior. Cuando se hace submuestreo de un canal, se reduce el tamaño de dicho canal sin afectar a los demás. En el algoritmo JPEG, el submuestreo de los canales de crominancia consiste en reducir a la mitad el ancho y el alto de los canales Cb y Cr (en lo que se conoce como YCbCr 4:2:2) o solo el ancho (YCbCr 4:2:1). Esto permite aprovechar que el ojo humano es más sensible a los cambios de luminosidad (que viene dada por el canal Y) que a los cambios de color (determinados por los otros dos canales). Por ello, el primer paso ya consigue reducir el tamaño en disco de la imagen a la mitad (si se usa YCbCr 4:2:2) o a dos tercios (YCbCr 4:2:1) del de la original con una pequeña pérdida de información de color.

Tras aplicar la transformada discreta del coseno en cada cuadro $8 \times 8$ de cada canal de la imagen se obtiene una matriz $8 \times 8$ que, por la propiedad de compactación de energía de la DCT-II, tendrá coeficientes cada vez menores en las componentes más a la derecha y más hacia abajo. En la operación de cuantización se reduce la precisión con la que se almacenan los coeficientes como consecuencia de la división por la matriz de cuantización y el redondeo posterior, facilitando que los coeficientes de la parte de abajo a la derecha tomen valores enteros dentro de un rango más pequeño y con mayor probabilidad de ser cero, lo que permite que los algoritmos de compresión sin pérdida posteriores almacenen dichos valores con poco espacio. En general las matrices de cuantización tienen coeficientes proporcionales a la cantidad de compresión que se desee obtener, y más altos en las componentes de abajo a la derecha, facilitando el descarte de información de alta frecuencia. Esta operación de cuantización es la que supone que en el algoritmo JPEG pueda haber una pérdida notable de información (a cambio de un factor de compresión destacablemente bueno), pues los errores de redondeo al aplicar la DCT-II y el submuestreo de los canales de crominancia producen errores inapreciables.

Para el estándar se escogió $8 \times 8$ como las dimensiones de los bloques. Un valor mayor supondría cálculos más pesados que, según se ha comprobado empíricamente, no aportan una mejora considerable de la razón de compresión [@salomon2007data] [@nelson1996data], y un valor menor supone un menor aprovechamiento de la correlación de los píxeles próximos [@nelson1996data].

Dado que cada bloque se trata de forma independiente, es posible que se vean bordes de bloques en una imagen excesivamente comprimida como consecuencia de que los errores de redondeo, que dependen de la matriz de cuantización, provoquen que se aproxime la imagen de forma distinta en cada uno. Otro artefacto común es la aparición de patrones irregulares en los límites de zonas de la imagen planas.

## Compresión de archivos de sonido

Uno de los artefactos descritos en la codificación de archivos JPEG es la aparición de saltos como consecuencia de que los bloques se comprimen independientemente. Este fenómeno no es aceptable en archivos de sonido, pues un pequeño salto cada cierto número de muestras provocaría la aparición de un ruido. Utilizar bloques más grandes eliminaría este problema, pero a costa de un tiempo de procesamiento elevado.

Dada una secuencia de números reales de longitud par $\{x\} = x_0,\,\dots\,x_{2N-1}$, se define la transformada discreta del coseno modificada, **MDCT**, de la siguiente forma:

$$\text{MDCT}\{x\}_k = \sum_{n=0}^{2N-1} x_n \cos \left( \frac \pi N \left(n + \frac {N+1} 2 \right) \left(k + \frac 1 2 \right) \right) \quad \forall k \in \{0,\,\dots\,N-1\}$$

Esta transformada va de $\mathbb R^{2N}$ a $\mathbb R^N$. Para evitar perder información, esta transformada se aplica de forma solapada en cada par de bloques de $N$ muestras consecutivos, de forma que cada bloque de $N$ muestras se usa en dos transformadas; y para recuperar los valores originales se aplica su transformada inversa sobre cada par de bloques consecutivos:

$$\text{IMDCT}\{x\}_k = \frac 1 N \sum_{n=0}^{N-1} x_n \cos \left( \frac \pi N \left(k + \frac {N+1} 2 \right) \left(n + \frac 1 2 \right) \right) \quad \forall k \in \{0,\,\dots\,2N-1\}$$

Una vez que se tienen dos valores en cada muestra (uno de la transformada del bloque que lo contiene y el anterior, otro de la transformada del bloque que lo contiene y el siguiente), se suman, de forma que el error se cancela. Este procedimiento se conoce como _time-domain aliasing cancellation_.

En general, los distintos algoritmos de compresión utilizan un tamaño de bloque adaptable según la forma de la onda en el entorno de las muestras. Al igual que en JPEG, una vez que se obtiene la secuencia de intensidades de frecuencia en cada bloque, se aplica un proceso de cuantización que provoca que se descarte información, particularmente de las frecuencias altas.

A cambio de suavizar el problema de los saltos en los bordes de bloques, el error se dispersa en el tiempo, por lo que en las aplicaciones de esta transformada suele aparecer el problema del preeco, que consiste en que, cuando un sonido fuerte sucede a un silencio, se oye una pequeña distorsión justo antes del sonido [@salomon2007data]. Los diversos códecs que utilizan esta transformada (MPEG-3, AAC y Ogg Vorbis entre otros) lo hacen tras un preprocesado complejo en el que intentan, entre otros cometidos, minimizar este efecto.
