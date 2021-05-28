pdflatex := /usr/bin/pdflatex
bibtex := /usr/bin/bibtex

SOURCES := $(wildcard images/*.tex)
IMAGES := $(patsubst images/%.tex, images/%.pdf, $(SOURCES))

paper:
	$(pdflatex)  -interaction nonstopmode main.tex
	$(bibtex) main.aux
	$(pdflatex)  -interaction nonstopmode main.tex
	$(pdflatex)  -interaction nonstopmode main.tex

all:	$(IMAGES) paper

clean:
	rm -rf *.soc *.out *.log *.blg *.bbl *.aux *.thm *.pgf-plot.gnuplot *.loc *.synctex.gz *.upa *.upb
	cd images && rm -rf *.soc *.out *.log *.blg *.bbl *.aux *.thm *.pgf-plot.gnuplot  *.loc *.synctex.gz *.upa *.upb && cd ..
	cd sections && rm -rf *.soc *.out *.log *.blg *.bbl *.aux *.thm *.pgf-plot.gnuplot *.pdf *.loc *.synctex.gz *.upa *.upb && cd ..
	
images/%.pdf:	images/%.tex
	pdflatex -interaction nonstopmode -output-directory images $<
	
zip:    clean
	zip -r compress.zip . -x datasets/**\* -x -x templates/**\* -x old_Response.tex -x .git/**\* -x main.pdf  -x copyright.pdf
