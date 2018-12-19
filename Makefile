PANDOC:=pandoc
FILTERS:=filters/env.hs filters/pandoc-crossref pandoc-citeproc
PFLAGS:=$(foreach filter,$(FILTERS),-F $(filter))

DOC_FOLDER:=./trabajo
DOC_SECTIONS:=intro.md definiciones.md propiedades.md complejidad.md algoritmosFFT.md coseno.md cuantica.md aplicaciones.md final.md
DOC_SRCS:= $(foreach section, $(DOC_SECTIONS), $(DOC_FOLDER)/$(section))

PR_FOLDER:=./presentacion
PR_SECTIONS:=intro.md definiciones.md complejidad.md algoritmosFFT.md cuantica.md
PR_SRCS:= $(foreach section, $(PR_SECTIONS), $(PR_FOLDER)/$(section))

PDFS:=trabajo.pdf presentacion.pdf

.PHONY: all clean check

all: $(PDFS)

trabajo.pdf: $(DOC_SRCS) assets/citas.bib
	$(PANDOC) $(PFLAGS) -H assets/math.sty  $(DOC_SRCS) -o $@

presentacion.pdf: $(PR_SRCS) assets/citas.bib
	$(PANDOC) $(PFLAGS) -t beamer $(PR_SRCS) -o $@

clean:
	rm $(PDFS)
