import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
    static targets = ["modal"];

    modal = null;

    connect() {
        this.modal = new Modal(this.modalTarget);
    }

    show() {
        this.modal.show();
    }

    hide() {
        this.modal.hide();
    }

    toggle() {
        this.modal.toggle();
    }
}
