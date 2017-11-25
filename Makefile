NOTE_NAMES = Prob1 Prob2 Prob3 Prob4 
NOTE_DIRS = $(addprefix notes/, $(addsuffix /, $(SUB_NAMES)))
NOTE_PDFS =   $(join $(SUB_DIRS), $(addsuffix .pdf, $(SUB_NAMES)))
NOTE_TEXS = $(SUB_PDFS:.pdf=.tex)


NOTE_DEPEND = $(NOTE_TEXS) 

LATEXMK = latexmk -use-make -pdf -dvi- -ps- 

all: main.pdf $(NOTE_PDFS)

parts: $(NOTE_PDFS)

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
	
publish: all parts
	find . -path ./docs -prune -o -name "*.pdf" -exec cp {} docs \;