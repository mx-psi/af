---
title: Transformada de Fourier discreta
author: 
- Pablo Baeyens Fernández
- Luis Balderas Ruiz
- Francisco Javier Morales Piqueras
- José Manuel Muñoz Fuentes
subtitle: Análisis de Fourier
date: Curso 2018 - 2019
documentclass: scrartcl
colorlinks: true
bibliography: assets/citas.bib
biblio-style: apalike
link-citations: true
citation-style: assets/estilo.csl
secnumdepth: 2
toc-depth: 2
numbersections: true
linkReferences: true
toc: true
prefixes:
  dfn:
    ref: ['definición','definiciones']
  prop:
    ref: ['prop.','props.']
  thm:
    ref: ['teorema','teoremas']
  lemma:
    ref: ['lema','lemas']
  algo:
    ref: ['algoritmo','algoritmos']
  cor:
    ref: ['corolario','corolarios']
  paso:
    ref: ['paso','pasos']
---

# Introducción

La transformada de Fourier tiene su equivalente en el caso discreto, conocida como *transformada discreta de Fourier*, que consta de un gran número de aplicaciones en el tratamiento digital de señales, la compresión de datos y la resolución eficiente de problemas de teoría de números mediante el uso de algoritmos cuánticos. 

Este documento puede dividirse en tres secciones: la definición y propiedades, su cálculo eficiente y algunas aplicaciones.

En la primera parte (secciones [Definiciones] y [Propiedades]) presentamos esta transformada y sus propiedades, que muestran una fuerte analogía con la transformada de Fourier en el caso continuo, obteniendo resultados como el teorema de convolución ([@thm:conv]), el teorema de Plancherel ([@cor:plancherel]) o el teorema de inversión ([@cor:isometries]).

A continuación (sección [La Transformada de Fourier rápida]) mostramos cómo calcular de forma eficiente esta transformada mediante el uso de algoritmos de *transformada de Fourier rápida* como el [Algoritmo de Cooley-Tukey] y calculamos su complejidad algorítmica.

Por último vemos desarrollamos aplicaciones notables de la transformada discreta de Fourier y sus transformadas asociadas: la compresión de archivos multimedia a partir de [La transformada discreta del coseno] (la parte real de la transformada discreta de Fourier), el cálculo de [La transformada de Fourier cuántica] así como su aplicación para la resolución de forma eficiente del problema de la factorización de enteros y [Otras aplicaciones].



\newpage
