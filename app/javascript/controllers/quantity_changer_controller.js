import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="quantity-changer"
export default class extends Controller {
    static targets = ["input", "result"];


    connect() {
        console.log("init quantity")
    }

    plus() {
        this.inputTarget.value++
        this.dispatchChangeEvent()
        this.uptadeResult()
    }

    minus() {
        this.inputTarget.value--
        this.dispatchChangeEvent()
        this.uptadeResult()
    }

    uptadeResult() {
        this.resultTarget.innerText = this.inputTarget.value
    }

    dispatchChangeEvent(){
        let changeEvent = new Event('input')
        this.inputTarget.dispatchEvent(changeEvent)
    }
}
