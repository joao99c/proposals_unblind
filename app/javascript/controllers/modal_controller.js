import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
    static targets = ["modal"];

    modal = null;

    connect() {
        this.modal = new Modal(this.modalTarget);
        console.log("Modal connected");
    }

    show() {
        this.modal.show();
        console.log("Modal show");
    }

    hide() {
        this.modal.hide();
        console.log("Modal hide");
    }

    toggle() {
        this.modal.toggle();
        console.log("Modal toggle");
    }
}
