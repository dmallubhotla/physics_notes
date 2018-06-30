NOTE_NAMES = DrudeTheory DerivingThomasFermi ReducingLindhard LindhardExplicitParts QubitRelaxation
NOTE_DIRS = $(addprefix notes/, $(addsuffix /, $(NOTE_NAMES)))
NOTE_PDFS =   $(join $(NOTE_DIRS), $(addsuffix .pdf, $(NOTE_NAMES)))
NOTE_TEXS = $(NOTE_PDFS:.pdf=.tex)


NOTE_DEPEND = $(NOTE_TEXS)

#DEFINE ALL THE INDIVIDUAL NOTE DEPENDENCIES HERE AS CONSTANTS

LATEXMK = latexmk -use-make -pdf -dvi- -ps-

all: main

main: main.pdf $(NOTE_PDFS)

parts: $(NOTE_PDFS)

#TARGETS FOR INDIVIDUAL NOTE PDFS

%.pdf: %.tex
	cd $(<D); $(LATEXMK) $(<F)


main.pdf: main.tex $(NOTE_DEPEND)
	$(LATEXMK) main.tex

.PHONY: tidy clean docs publish

tidy:
	latexmk -c
	for dir in $(NOTE_DIRS); do\
		(cd $$dir; latexmk -c) ;\
	done;

clean:
	latexmk -C
	for dir in $(NOTE_DIRS); do\
		(cd $$dir; latexmk -C) ;\
	done;
	rm docs/*.pdf

publish: main parts
	find . -path ./docs -prune -o -name "*.pdf" -exec cp {} docs \;