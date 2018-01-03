# stimulusjs usage w/o webpack

## es6 modules

| code        | type        | minified |
| ------------| ----------- | -------- |
| stimulusjs  | UMD         | x        |
| app         | es6 modules |          |

~~~
$ npm i
$ make -f es6-modules.mk

$ ruby -run -ehttpd _out -p9000 &
$ xdg-open http://127.0.0.1:9000
~~~
