.PHONY: build install
all:

build:
	docker build -t cajanzen/texbuilder .
install:
	[ -d ~/bin ] && cp script/* ~/bin
