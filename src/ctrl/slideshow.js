/* globals Stimulus */
export default class extends Stimulus.Controller {
    initialize() {
	this.render()
    }

    next() {
	if (this.index < this.lastIndex) this.index++
    }

    prev() {
	if (this.index > 0) this.index--
    }

    render() {
	this.slideElements.forEach((element, index) => {
	    element.classList.toggle("slide--current", index === this.index)
	})
    }

    get index() {
	if (this.data.has("index")) {
	    return parseInt(this.data.get("index"))
	}
	return 0
    }

    set index(value) {
	this.data.set("index", value)
	this.render()
    }

    get lastIndex() {
	return this.slideElements.length - 1
    }

    get slideElements() {
	return this.targets.findAll("slide")
    }
}
