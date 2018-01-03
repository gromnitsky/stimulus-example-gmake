NODE_ENV := development
out := _out.$(basename $(lastword $(MAKEFILE_LIST))).$(NODE_ENV)
include common.mk



static.src := $(shell find src/ -type f)
static.dest := $(subst src/, $(out)/, $(static.src))

$(static.dest): $(out)/%: src/%
	$(mkdir)
	$(copy)

compile.all += $(static.dest)



compile: $(compile.all)
