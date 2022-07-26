import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="discount-input"
export default class extends Controller {
    static targets = ["input", "discountSection"];

    connect() {
        this.inputTargets.forEach(input => {
            input.addEventListener("input", this.handleInput.bind(this));
            this.handleInput.bind(this)({currentTarget: input});
        });
    }

    handleInput(event) {
        if (event.currentTarget.value === "fixed" || event.currentTarget.value === "percent") { // None
            this.discountSectionTarget.classList.remove("hidden");
        } else {
            this.discountSectionTarget.classList.add("hidden");
        }
    }
}
