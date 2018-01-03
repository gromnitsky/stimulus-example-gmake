NODE_ENV := development
out := _out.$(basename $(lastword $(MAKEFILE_LIST))).$(NODE_ENV)
include common.mk



static.src := $(shell find src/ -type f \! -name \*.js \! -name \*.html)
static.dest := $(subst src/, $(out)/, $(static.src))

$(static.dest): $(out)/%: src/%
	$(mkdir)
	$(copy)

compile.all += $(static.dest)



$(out)/index.html: src/index.html
	$(mkdir)
	sed 's/type="module"//' $< > $@

compile.all += $(out)/index.html



js.src := $(shell find src/ -type f -name \*.js)
rollup.opt = -m -o $@
ifeq ($(NODE_ENV),production)
rollup.opt = -o $@.rollup
endif

$(out)/main.js: $(js.src)
	$(mkdir)
	rollup -f iife src/main.js $(rollup.opt)
ifeq ($(NODE_ENV),production)
	babel --no-comments --presets `npm -g root`/babel-preset-es2015 $@.rollup -o $@.babel
	uglifyjs $@.babel -o $@ -mc
	rm $@.*
endif

compile.all += $(out)/main.js



compile: $(compile.all)
