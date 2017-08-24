docs/app.js: main.js src/*.js node_modules
	browserify src/app.js > docs/app.js

main.js: src/*.elm
	elm-make src/main.elm --output main.js --warn --yes

node_modules:
	yarn install
