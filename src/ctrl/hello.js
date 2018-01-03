/* globals Stimulus */
export default class extends Stimulus.Controller {
    greet() {
	let element = this.targets.find("name")
	alert(`Hello, ${element.value}!`)
    }

    copy_to_cb() {
	this.targets.find("name").select()
	document.execCommand("copy")
    }
}
