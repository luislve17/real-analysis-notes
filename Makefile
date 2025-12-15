watch:
	find . -name "*.tex" | entr -r latexmk -pdf $1

export:
	latexmk -pdf -f main.tex
