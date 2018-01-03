# stimulusjs usage w/o webpack

| code        | type        | minified |
| ------------| ----------- | -------- |
| stimulusjs  | UMD         | x        |
| app         | es6 modules |          |

~~~
$ make
$ ruby -run -ehttpd _out -p9000 &
$ xdg-open http://127.0.0.1:9000
~~~
