
source = $(shell find ./src/ -name "*.elm")
elm-bundle = build/bundle.js
elm-doc-bundle = build/docs.js
webpack-bundle = build/webpack-bundle.js
electron-entry-point = ./static/electron.js

.PHONY: elm-reactor default electron server

default: webpack-dev-server

elm: $(elm-bundle)

$(elm-bundle): $(source)
	elm-make $(source) --output $(elm-bundle) --docs=$(elm-doc-bundle)

$(webpack-bundle): $(source)
	./node_modules/.bin/webpack

electron:HOST=localhost
electron:WEBPACK_PORT=8667
electron:
	./node_modules/.bin/webpack-dev-server --host $(HOST) --port $(WEBPACK_PORT) --content-base /build/ &
	./node_modules/.bin/electron $(electron-entry-point)

server:PORT=8001
server:HOST=0.0.0.0
server:WEBPACK_PORT=8314
server:
	./node_modules/.bin/webpack-dev-server --host $(HOST) --port $(WEBPACK_PORT) --content-base /build/ &
	@echo "http://$(HOST):$(PORT)/src/static/index.html"
	python -mSimpleHTTPServer $(PORT)

elm-reactor:
	elm-reactor
