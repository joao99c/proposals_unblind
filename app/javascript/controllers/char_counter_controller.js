import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="char-counter"
export default class extends Controller {
    static targets = ['input', 'output']

    connect() {
        this.inputTarget.addEventListener('input', this.update.bind(this))
        this.update()
    }

    update() {
        // if inputTarget is a textarea
        if (this.inputTarget.tagName == 'TEXTAREA') {
            this.outputTarget.innerHTML = this.inputTarget.value.length
        }
        if (this.inputTarget.tagName == 'TRIX-EDITOR') {

            // Limit the length of the trix-editor
            let max_length = parseInt(this.inputTarget.getAttribute('maxlength')) - 1 || 200;
            let current_length = this.inputTarget.editor.getDocument().toString().length;
            console.log(current_length)
            if (current_length >= max_length) {
                this.inputTarget.editor.setSelectedRange([max_length, current_length])
                this.inputTarget.editor.deleteInDirection("forward")
            }
            this.outputTarget.innerHTML = this.inputTarget.editor.getDocument().toString().length;

            // let chart_count = this.inputTarget.editor.getDocument().getLength() - 1
            // let max_length = parseInt(this.inputTarget.getAttribute('maxlength'))
            // if(chart_count >= max_length) {
            //     // Delete the last character
            //     this.inputTarget.editor.deleteInDirection('forward')
            //     this.inputTarget.editor.deleteInDirection('forward')
            //     // this.inputTarget.editor.setSelectedRange([max_length, chart_count])
            //     // this.inputTarget.editor.deleteInDirection("forward")
            // }
            // this.outputTarget.innerHTML = chart_count
        }
    }
}
