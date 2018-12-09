PANDOC:=pandoc
FILTERS:= filters/env.hs filters/pandoc-crossref pandoc-citeproc
PFLAGS:= $(foreach filter,$(FILTERS),-F $(filter))
SRCS:= 1.intro.md 2.definiciones.md 3.convolucion.md 4.propiedades.md 5.complejidad.md 6.algoritmosFFT.md 7.aplicaciones.md 8.compresion.md 9.cuantica.md 10.final.md


.PHONY: all clean check

all: trabajo.pdf

trabajo.pdf: $(SRCS) assets/citas.bib
	$(PANDOC) $(PFLAGS) -H assets/math.sty  $(SRCS) -o $@

clean:
	rm trabajo.pdf
