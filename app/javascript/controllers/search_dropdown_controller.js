import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="search-dropdown"
export default class extends Controller {
    static targets = ["input", "dropdown"];

    connect() {
        this.inputTarget.addEventListener("focusin", () => this.showDropdown())
        this.inputTarget.addEventListener("focusout", () => this.hideDropdown())
    }

    showDropdown() {
        this.dropdownTarget.style.display = "block"
    }

    hideDropdown() {

        setTimeout(() => {
            var focus=document.activeElement;
            if (focus === this.element || this.element.contains(focus)) {
            } else {
                this.dropdownTarget.style.display = "none"
            }
        },0);
    }
}
