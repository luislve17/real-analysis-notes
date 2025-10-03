watch:
	find . -name "*.tex" | entr -r latexmk -pdf main.tex

export:
	latexmk -pdf main.tex
