CONTAINER_NAME := tex
CONTAINER_IMAGE := registry.fedoraproject.org/fedora-toolbox:latest

.PHONY: setup-tex watch watch-container export

setup-tex:
	@if ! distrobox list --no-color 2>/dev/null | grep -qw "$(CONTAINER_NAME)"; then \
		echo "Container '$(CONTAINER_NAME)' not found, creating..."; \
		distrobox create --name $(CONTAINER_NAME) --image $(CONTAINER_IMAGE); \
	fi
	@if distrobox-enter $(CONTAINER_NAME) -- which latexmk >/dev/null 2>&1; then \
		echo "DONE (latexmk already present)"; \
	else \
		echo "latexmk not found, installing texlive-scheme-medium..."; \
		distrobox-enter $(CONTAINER_NAME) -- sudo dnf install -y latexmk texlive-scheme-medium && \
		echo "DONE (installed)"; \
	fi

watch-container: setup-tex
	find . -name "*.tex" | entr -r distrobox-enter $(CONTAINER_NAME) -- latexmk -pdf -interaction=nonstopmode main.tex
