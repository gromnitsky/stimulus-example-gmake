# stimulusjs usage w/o webpack

Assume no server-side code. No yarn is necessary. The results of the
"build" step is `_out.TYPE.ENV` dir (like `_out.bundle.development`)
that is self-sufficient.

[Demo](http://gromnitsky.users.sourceforge.net/js/examples/stimulus-example-gmake)

Preliminaries:

	$ npm i
	$ ruby -run -ehttpd . -p9000 &


## es6 modules

| code        | type        | minified |
| ----------- | ----------- | -------- |
| stimulusjs  | UMD         | x        |
| app         | es6 modules |          |

~~~
$ make -f es6-modules.mk
$ xdg-open http://127.0.0.1:9000/_out.es6-modules.development
~~~

It's not very exciting for all we do is copy the files to the output
dir.


## es5 ulgified bundle

| code        | `NODE_ENV` === 'production'  | type            | minified |
| ----------- | ---------------------------- | --------------- | -------- |
| stimulusjs  |                              | UMD             | x        |
|             | x                            | UMD             | x        |
| app         |                              | es6 iife bundle |          |
|             | x                            | es5 iife bundle | x        |

	# npm -g i rollup babel-cli babel-preset-es2015 uglify-js

Create an es6 bundle ("development" mode using rollup only):

	$ make -f bundle.mk
	$ xdg-open http://127.0.0.1:9000/_out.bundle.development

An es5 uglified bundle ("production" mode: rollup+babel+uglify-js):

	$ make -f bundle.mk NODE_ENV=production
	$ xdg-open http://127.0.0.1:9000/_out.bundle.production


## How do I recompile on changes?

	# npm i -g watchthis

Then in the repo dir:

	$ watchthis -e _out\* -- make -f bundle.mk


## Auto-invoke npm

If you don't want to run `npm i` manually, add smth like:

~~~
include $(out)/.node_modules.mk

$(out)/.node_modules.mk: package.json
	$(mkdir)
	npm i
	@touch $@
	@echo Restarting Make

$(vendor.dest): $(out)/.node_modules.mk
~~~

I.e., when you change `package.json` & invoke Make, it runs `npm i`,
[restarts itself][1] then populates the DAG again. That is why var
`vendor.dest` becomes non-empty even if Make was invoked w/o
`node_modules` dir present.

[1]: https://www.gnu.org/software/make/manual/html_node/Remaking-Makefiles.html#Remaking-Makefiles)


## A single bundle

If you like to have exactly 1 script tag, i.e., instead of

~~~
<!-- deps -->
<script src="vendor/stimulus/dist/stimulus.umd.js"></script>
<!-- our code -->
<script src="main.js"></script>
~~~

you prefer (why?)

~~~
<script src="main.js"></script>
~~~

it's possible to employ rollup to include the whole src code of
stimulus into the bundle.

1. `$ npm i rollup-plugin-node-resolve`

2. Add the corresponding import lines to `src/main.js` (`import {
	Application } from "stimulus"`) & to `src/ctrl/*` (`import {
	Controller } from "stimulus"`). Change `
	Stimulus.Application.start()` to ` Application.start()`, &c. (See
	[INSTALLING.md in the stimulus repo][2].)

3. Replace the recipe for `$(out)/main.js` target (in `bundle.mk`) w/:

	~~~
	$(out)/main.js: $(js.src)
		$(mkdir)
		rollup -f iife -c cf.rollup.node-modules.js src/main.js $(rollup.opt)
		...
	~~~

	where `cf.rollup.node-modules.js` is:

	~~~
	import resolve from 'rollup-plugin-node-resolve';
	export default {
		plugins: [ resolve() ]
	};
	~~~

[2]: https://github.com/stimulusjs/stimulus/blob/master/INSTALLING.md
