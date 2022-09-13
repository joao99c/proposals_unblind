import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
    static targets = ["modal"];

    modal = null;

    connect() {
        this.modal = new Modal(this.modalTarget, {
            onHide: () => {
                console.log('modal is hide');
            },
            onShow: () => {
                console.log('modal is shown');
                let bd = document.querySelector("div[modal-backdrop]")
                bd.id = "modal-backdrop"
            },
        });
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
