watch:
	find . -name "*.tex" | entr -r latexmk -pdf $1

export:
	latexmk -pdf -f main.tex

watch-container:
	find . -name "*.tex" | entr -r distrobox-enter tex -- latexmk -pdf -interaction=nonstopmode main.tex

