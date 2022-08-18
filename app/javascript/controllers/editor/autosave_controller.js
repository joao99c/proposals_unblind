import {Controller} from "@hotwired/stimulus"
import {debounce} from "lodash-es";
import {Turbo} from "@hotwired/turbo-rails";

// Connects to data-controller="editor--autosave"
export default class extends Controller {
    save() {
        this.saveNow();
        this.save = debounce(() => {
            this.saveNow();
        }, 250);
    }

    saveNow() {
        if (this.element.reportValidity()) {
            Turbo.navigator.submitForm(this.element);
        }
    }
}

