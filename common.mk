mkdir = @mkdir -p $(dir $@)
copy = cp $< $@

compile.all :=
compile:

vendor.src := stimulus/dist/stimulus.umd.js
vendor.dest := $(addprefix $(out)/vendor/, $(vendor.src))

$(out)/vendor/%: node_modules/%
	$(mkdir)
	$(copy)

compile.all += $(vendor.dest)
