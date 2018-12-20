# Transformada discreta del coseno

## Archivos multimedia

Para construir una imagen o sonido digital se siguen estos pasos:

 - **Muestrear** una señal
 - **Cuantizar** las muestras
 - **Almacenar** los valores cuantizados

Se puede construir una aproximación de la señal analógica original a partir de estos valores.

 - El **número de muestras** viene determinado por la frecuencia de muestreo o la resolución.
 - El logaritmo en base $2$ del cardinal del conjunto de valores posibles en la cuantización es la **profundidad** de bits.

## Formato de archivos en bruto

En el formato de archivos en bruto se almacenan los valores cuantizados de las muestras siguiendo un orden de muestras canónico.

El producto del número de muestras y la profundidad de bits determina el **tamaño** del archivo en bits y la calidad de la reconstrucción.

En general tanto el número de muestras como la profundidad de bits vienen impuestas, pues la reconstrucción se degrada notablemente por debajo de ciertos valores y, salvo con el número de muestras de imágenes, no mejora notablemente cuando estas aumentan.

## Tamaño de archivos en bruto

:::{.examples}
Una fotografía en color de $8$ megapíxeles contiene $8 \cdot 10^6$ muestras de $24$ bits cada una, lo que da lugar a un tamaño de archivo de $29$ MB.

Un minuto de archivo de sonido estéreo de $44\,100$ muestras por segundo de $16$ bits cada una ocupa $10$ MB.

Un **segundo** de vídeo (sin sonido) en HD 1080p ocupa $148$ MB.
:::

. . .

Y todos estos formatos empiezan a estar obsoletos.

Es necesario buscar una forma de comprimir los archivos multimedia sin reducir la frecuencia de muestreo o la profundidad de bits.

## Algoritmos genéricos de compresión sin pérdida

Hay multitud de algoritmos que explotan la redundancia de secuencias de bits para reducir su tamaño:

 - Métodos estadísticos
   - Codifican en menor espacio los valores medidos más comunes
 - Métodos de diccionario
   - Comprimen mejor datos con muchas secuencias repetidas

Pero en los archivos multimedia:

 - La distribución de los valores medidos en las muestras es aproximadamente uniforme
 - No se suelen repetir secuencias exactas

Por ello, resultan poco eficaces en contenido multimedia.

## Transformaciones

Aunque estos algoritmos no la puedan explotar, hay cierta redundancia en los archivos multimedia: las muestras cercanas en el espacio y el tiempo suelen tener valores similares, aunque no idénticos.

Otros algoritmos de compresión se basan en obtener el resultado de aplicar una transformación invertible a la señal discretizada que se quiere almacenar.

En principio esto no reduce el tamaño de archivo, pues si no hay restricciones sobre las posibles señales la señal transformada requerirá el mismo tamaño.

## Utilidad de las transformaciones

Sin embargo:

 - Es posible que tras la transformación los valores sí sigan una distribución no uniforme por la naturaleza del fenómeno original, y por tanto comprimible mediante métodos estadísticos.
 - Además, si la secuencia transformada contiene multitud de valores nulos consecutivos, se podrá obtener una notable compresión mediante métodos de diccionario.
 - Si, adicionalmente, algunos valores próximos a cero se almacenan como el mismo valor (en particular, se almacenan como cero valores próximos a cero), se consigue una compresión mayor a cambio de **pérdida** de información, pues deja de ser posible revertir la transformación.

## Compresión con pérdida y sin pérdida
 
Una transformación podrá facilitar la compresión de alguna de estas formas si explota la naturaleza del fenómeno grabado, en lo que se puede llamar aplicación de **conocimiento experto** de dicha naturaleza.

El formato de imagen PNG y el códec de sonido FLAC implementan los dos primeros puntos, con lo que obtienen **compresión sin pérdida**. En el caso del estándar de imágenes JPEG y varios formatos de sonido, veremos que especifican algoritmos de **compresión con pérdida**, pues también realizan la tercera operación: descartan información a cambio de mayor razón de compresión.

## Descomposición de una señal discreta

Las transformaciones consideradas suelen consistir en descomponer la imagen o sonido en fragmentos y describirlos como combinación lineal de ondas elementales.

Dado que las muestras cercanas suelen tomar valores próximos, es de esperar que las frecuencias altas tengan menor intensidad, por lo que los coeficientes asociados a las ondas elementales de mayor frecuencia son menores.

De esta forma se podrá comprimir la señal, pues se requerirá poca información para guardar las frecuencias altas; incluso menos si estas se cuantizan más.

## Por qué no nos sirve la transformada discreta de Fourier

Aunque la transformada discreta de Fourier realiza esto, podría llevar una secuencia de números reales a una secuencia de números complejos.

Sin embargo, un número complejo necesita el doble de información para ser almacenado con el mismo margen de error en forma binómica, lo que resulta contraproducente.

Interesa buscar una transformación similar que lleve secuencias de números reales en secuencias de números reales. Para ello es suficiente que su matriz regular asociada tenga coeficientes reales.

## Extensión par

Nótese que no basta con tomar parte real en la matriz de coeficientes de la transformada discreta de Fourier: la columna $k$ es igual a la columna $n-k$ y por ello la matriz es singular.

Una forma de obtener una transformada que maneje números reales es extender por simetría par una secuencia y aplicarle la transformada de Fourier discreta. De esta forma, para una secuencia de números reales de entrada, las partes imaginarias de los coeficientes se anulan y se obtiene una secuencia de números reales.

## Extensiones pares estándar

Existen cuatro formas típicas de extender una secuencia de números reales de forma par, según dónde se sitúe el punto de simetría y según si se aplica primero una simetría impar:

<div>

\quad ![Extensión 1](imgs/extension1.pdf){width=42%}
\quad ![Extensión 2](imgs/extension2.pdf){width=42%}

\quad ![Extensión 3](imgs/extension3.pdf){width=42%}
\quad ![Extensión 4](imgs/extension4.pdf){width=42%}

</div>

## Transformadas discretas del coseno

Operando con las expresiones se obtienen las cuatro transformadas discretas del coseno típicas (con $\{x\} \in \mathbb R^N$):

 - $\displaystyle \textbf{DCT-I}\{x\}_k = \sum_{n=0}^{N-1} \alpha_n x_n \cos\left(\frac{\pi k n}{N - 1}\right)$ 
 - $\displaystyle \textbf{DCT-II}\{x\}_k = \sum_{n=0}^{N-1} x_n \cos\left(\frac{\pi k (n + \frac 1 2)}{N}\right)$
 - $\displaystyle \textbf{DCT-III}\{x\}_k = \sum_{n=0}^{N-1} \beta_n x_n \cos\left(\frac{\pi (k + \frac 1 2) n}{N}\right)$
 - $\displaystyle \textbf{DCT-IV}\{x\}_k = \sum_{n=0}^{N-1} x_n \cos\left(\frac{\pi (k + \frac 1 2) (n + \frac 1 2)}{N}\right)$

Donde $\displaystyle \alpha_i = \left\{ \begin{array}{cl} \frac 1 2 & \text{si } i \in \{0,\, N-1\} \\ 1 & \text{en otro caso} \end{array} \right.$y $\displaystyle \beta_i = \left\{ \begin{array}{cl} \frac 1 2 & \text{si } i = 0 \\ 1 & \text{en otro caso} \end{array} \right.$

## Transformadas discretas del coseno normalizadas

Estas transformadas tienen una versión normalizada:

 - $\displaystyle \textbf{NDCT-I}\{x\}_k = \sqrt{\frac 2 {N-1}} \gamma_k \sum_{n=0}^{N-1} \gamma_n x_n \cos\left(\frac{\pi k n}{N - 1}\right)$
 - $\displaystyle \textbf{NDCT-II}\{x\}_k = \sqrt {\frac 2 N} \delta_k \sum_{n=0}^{N-1} x_n \cos\left(\frac{\pi k (n + \frac 1 2)}{N}\right)$
 - $\displaystyle \textbf{NDCT-III}\{x\}_k = \sqrt {\frac 2 N} \sum_{n=0}^{N-1} \delta_n x_n \cos\left(\frac{\pi (k + \frac 1 2) n}{N}\right)$
 - $\displaystyle \textbf{NDCT-IV}\{x\}_k = \sqrt {\frac 2 N} \sum_{n=0}^{N-1} x_n \cos\left(\frac{\pi (k + \frac 1 2) (n + \frac 1 2)}{N}\right)$

Donde $\displaystyle \gamma_i = \left\{ \begin{array}{cl} \frac 1 {\sqrt 2} & \text{si } i \in \{0,\, N-1\} \\ 1 & \text{en otro caso} \end{array} \right.$y $\displaystyle \delta_i = \left\{ \begin{array}{cl} \frac 1 {\sqrt 2} & \text{si } i = 0 \\ 1 & \text{en otro caso} \end{array} \right.$

## Transformadas discretas del coseno normalizadas

Las matrices asociadas a las versiones normalizadas son ortogonales. Además, la matriz transpuesta de la asociada a la NDCT-II es la matriz asociada a la NDCT-III; por lo cual una es inversa de la otra. De igual forma, la DCT-II y la DCT-III son inversas salvo constante de normalización.

Dado que las matrices asociadas a las versiones normalizadas son ortogonales, sus $N$ columnas forman un sistema ortonormal en un espacio de Hilbert de dimensión $N$, y por tanto un sistema ortonormal maximal. Por ello se tiene una identidad de Parseval para cada DCT.

## La DCT-II

En general, cuando se habla de _la_ transformada discreta del coseno se suele hacer referencia a la **DCT-II**, normalizada o no:

$$\textbf{DCT-II}\{x\}_k = \sum_{n=0}^{N-1} x_n \cos\left(\frac{\pi k (n + \frac 1 2)}{N}\right)$$
$$\displaystyle \textbf{NDCT-II}\{x\}_k = \sqrt {\frac 2 N} \delta_k \sum_{n=0}^{N-1} x_n \cos\left(\frac{\pi k (n + \frac 1 2)}{N}\right)$$

Con la DCT-II se tiene la identidad de Parseval
$$\langle \{x\},\,\{y\} \rangle = \frac 2 N \sum_{k=0}^{N-1} \beta_k (\text{DCT-II}\{x\})_k (\text{DCT-II}\{y\})_k$$

## Energía de una señal discreta

Y por consiguiente esta identidad de Plancherel:
$$\|\{x\}\|_2^2 = \langle \{x\},\,\{x\} \rangle = \frac 2 N \sum_{k=0}^{N-1} \beta_k (\text{DCT-II}\{x\})_k^2$$

En tratamiento de señales se define la **energía** de una señal continua $f$ como
$$E_f = \|f\|_2^2 = \int_{-\infty}^\infty |f(t)|^2 \, dt$$

En el caso discreto tenemos análogamente que la energía de una señal discreta $\{x\}$ es $E_{\{x\}} = \|\{x\}\|_2^2$. Por la identidad de Plancherel, la energía se reparte uniformemente entre los coeficientes de la transformada (salvo el primero)

## Ejemplos de transformadas

<div>

![Señal](imgs/ejemplo-senal.pdf){width=48%}
![DCT-II](imgs/ejemplo-dctii.pdf){width=48%}

![DFT parte real](imgs/ejemplo-dft-real.pdf){width=48%}
![DFT parte imaginaria](imgs/ejemplo-dft-imag.pdf){width=48%}

</div>

## Propiedad de compactación de energía

![Compactación de energía por la DCT-II](imgs/ejemplo-energia.pdf){width=80%}

## El formato de imagen JPEG

El conocido estándar JPEG describe un algoritmo de compresión con pérdida de imágenes basado en la NDCT-II bidimensional. Sea $P$ una matriz de números reales de dimensión $N \times N$, cada componente $i,j$ de la transformada se obtiene como
$$X_{ij} = \frac {\alpha_i \alpha_j} {\sqrt{2 N}} \sum_{x = 0}^{N-1} \sum_{y = 0}^{N-1} P_{xy} \cos\left(\frac{i \pi (2x + 1)}{2N}\right) \cos\left(\frac{j \pi (2y + 1)}{2N}\right)$$

donde $\alpha_k = 1$ si $k > 0$ y $\alpha_0 = \frac 1 {\sqrt 2}$.

La operación inversa se obtiene de la NDCT-III bidimensional. Para cada componente $x,y$
$$P_{xy} = \sqrt{2 N} \sum_{i = 0}^{N-1}  \sum_{j = 0}^{N-1} \alpha_i \alpha_j X_{ij} \cos\left(\frac{i \pi (2x + 1)}{2N}\right) \cos\left(\frac{j \pi (2y + 1)}{2N}\right)$$

## Algoritmo JPEG

El procedimiento para obtener una imagen JPEG a partir de un archivo de imagen en color en formato bruto es:

 - Pasar al espacio de color YCbCr 4:2:2
 - Agrupar los píxeles en cuadrados de $8 \times 8$, y en cada uno:
   - Aplicar la DCT-II bidimensional
   - Dividir componente a componente los coeficientes obtenidos por una **matriz de cuantización**
 - Escribir la información necesaria para decodificar este archivo (resolución, matriz de cuantización, coeficientes...)

La división por la matriz de cuantización no es exacta: redondea al entero más cercano, y por ello se pierde información en ella. Es este paso el que consigue una alta razón de compresión.

## La matriz de cuantización

El nivel de compresión depende de la matriz de cuantización: cuanto más altos sean sus valores, más estrecho es el rango de valores que pueden tomar los coeficientes (por tanto, más información se pierde y más eficaces son los métodos de compresión estadísticos).

En general se toman matrices de cuantización con valores más elevados hacia la esquina inferior derecha, con lo que se representa con menor exactitud la información de alta frecuencia. Esto aprovecha el hecho de que, en general, no suele ser importante en las imágenes fotográficas.

## Artefactos JPEG

![Ejemplo exagerado de artefactos JPEG](imgs/artefactos-jpeg.png){width=60%}

## La MDCT

En compresión de audio, para evitar la aparición de bloques, se usa una variante de la DCT-IV, que es la **MDCT**.

Asigna a cada $\{x\} \in \mathbb R^{2N}$ una secuencia de $\mathbb R^N$ así, para cada $k \in \{0,\,\dots\,N-1\}$:
$$\text{MDCT}\{x\}_k = \sum_{n=0}^{2N-1} x_n \cos \left( \frac \pi N \left(n + \frac {N+1} 2 \right) \left(k + \frac 1 2 \right) \right)$$

Se evita perder información aplicando esta transformada dos veces en cada bloque. La transformada inversa es su transpuesta dividida por $N$ y cada bloque se reconstruye como la suma de las mitades pertinentes de las dos secuencias que contribuye a generar.

## Compresión de audio

En distintos archivos de compresión de audio se utiliza una técnica similar a la de JPEG, con la MDCT y un tamaño de bloques adaptable.

El método de división y reconstrucción de bloques (_time-domain aliasing cancellation_) evita aparición de saltos pero produce otro tipo de distorsiones. Los distintos formatos de audio utilizan multitud de técnicas muy sofisticadas para filtrarlas.
