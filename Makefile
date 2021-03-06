# Build the JS documentation.
jsdocs: docs
	rm -rf ./docs/api/master
	./node_modules/.bin/jsdoc --configure ./.api-jsdoc-conf.json
	./node_modules/.bin/jsdoc --configure ./.api-jsdoc-conf.json --destination ./docs/api/master/internals/ --readme ./.api-internals.md --access all

	# Clean up the JS docs.
	for HTMLDOC in ./docs/api/*/*.html ./docs/api/*/*/*.html; do cat $$HTMLDOC | sed 's/<title>JSDoc: /<title>KSS JavaScript API: /' | sed -E 's/(Documentation generated by .+<\/a>).+/\1/' > $$HTMLDOC.tmp; mv $$HTMLDOC.tmp $$HTMLDOC; done

# Build the KSS demonstration.
docs: handlebars twig nunjucks
	./bin/kss --destination docs --demo

# Ensure Handlebars dependencies are installed.
builder/handlebars/node_modules:
	cd builder/handlebars && npm i

# Compile the Handlebars builder.
handlebars: builder/handlebars/node_modules
	cd builder/handlebars && npm run-script sass

# Ensure Twig dependencies are installed.
builder/twig/node_modules:
	cd builder/twig && npm i

# Compile the Twig builder.
twig: builder/twig/node_modules
	cd builder/twig && npm run-script sass

# Ensure Nunjucks dependencies are installed.
builder/nunjucks/node_modules:
	cd builder/nunjucks && npm i

# Compile the Nunjucks builder.
nunjucks: builder/nunjucks/node_modules
	cd builder/nunjucks && npm run-script sass
