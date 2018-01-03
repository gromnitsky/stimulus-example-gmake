NODE_ENV ?= development
out := _out.$(basename $(lastword $(MAKEFILE_LIST))).$(NODE_ENV)
mkdir = @mkdir -p $(dir $@)
copy = cp $< $@

compile.all :=
compile:



static.src := $(shell find src/ -type f)
static.dest := $(subst src/, $(out)/, $(static.src))

$(static.dest): $(out)/%: src/%
	$(mkdir)
	$(copy)

compile.all += $(static.dest)



vendor.src := stimulus/dist/stimulus.umd.js
vendor.dest := $(addprefix $(out)/vendor/, $(vendor.src))

$(out)/vendor/%: node_modules/%
	$(mkdir)
	$(copy)

compile.all += $(vendor.dest)



compile: $(compile.all)
