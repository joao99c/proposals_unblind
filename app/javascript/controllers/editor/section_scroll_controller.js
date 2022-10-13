import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="editor--section-scroll"
export default class extends Controller {
  scroll(e) {
    this.getPreviewItem(e).parentElement.scrollIntoView({ behavior: "smooth", block: "start" });
  }


  getPreviewItem(e) {
    return document.querySelector("iframe").contentDocument.getElementById(e.currentTarget.dataset.previewId)
  }
}
