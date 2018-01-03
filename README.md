# stimulusjs usage w/o webpack

	$ npm i
	$ ruby -run -ehttpd . -p9000 &

## es6 modules

| code        | type        | minified |
| ------------| ----------- | -------- |
| stimulusjs  | UMD         | x        |
| app         | es6 modules |          |

~~~
$ make -f es6-modules.mk
$ xdg-open http://127.0.0.1:9000/_out.es6-modules.development
~~~

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
