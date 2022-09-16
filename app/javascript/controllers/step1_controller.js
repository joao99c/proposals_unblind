import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="step1"
export default class extends Controller {
    static targets = ["button", "product", "customer"];

    connect() {
        this.checkButton(0)
    }

    checkButton(timeout){
        setTimeout(() => {
            // Check button
            this.buttonTarget.disabled = !(this.productTargets.length >= 1 && this.customerTargets.length >= 1);
            this.checkButton(1000)
        }, timeout);
    }
}
