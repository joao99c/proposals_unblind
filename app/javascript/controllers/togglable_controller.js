import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="togglable"
export default class extends Controller {
    static targets = ["button", "item"]

    connect() {
        this.buttonTargets.forEach(button => {
            button.addEventListener("click", this.toggle.bind(this));
        });
    }

    toggle() {
        this.itemTargets.forEach(item => {
            item.classList.toggle("hidden");
        });
    }
}