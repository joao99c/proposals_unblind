import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="editor--preview"
export default class extends Controller {
    connect() {
        console.log("preview controller connected")
    }

    show(e) {
        this.getPreviewItem(e).parentElement.style.display = "block"
        this.getPreviewItem(e).parentElement.scrollIntoView({ behavior: "smooth", block: "start" });
    }

    hide(e) {
        this.getPreviewItem(e).parentElement.style.display = "none"
        this.getPreviewItem(e).parentElement.scrollIntoView({ behavior: "smooth", block: "start" });
    }

    getPreviewItem(e) {
        return document.querySelector("iframe").contentDocument.querySelector(".preview_before_add_section #" + e.currentTarget.dataset.id)
    }
}
