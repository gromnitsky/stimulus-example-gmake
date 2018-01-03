/* globals Stimulus */
import HelloCtrl from "./ctrl/hello.js"
import SlideshowCtrl from "./ctrl/slideshow.js"

let app = Stimulus.Application.start()
app.register("hello", HelloCtrl)
app.register("slideshow", SlideshowCtrl)
