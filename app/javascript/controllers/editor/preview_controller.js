import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="editor--preview"
export default class extends Controller {
    connect() {
        console.log("preview controller connected")
    }

    show(e) {
        this.getPreviewItem(e).parentElement.style.display = "block"
    }

    hide(e) {
        this.getPreviewItem(e).parentElement.style.display = "none"
    }

    getPreviewItem(e) {
        return document.querySelector("iframe").contentDocument.querySelector(".preview_before_add_section #" + e.currentTarget.dataset.id)
    }
}
