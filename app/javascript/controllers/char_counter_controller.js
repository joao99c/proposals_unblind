import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="char-counter"
export default class extends Controller {
  static targets = ['input', 'output']

  connect() {
    this.inputTarget.addEventListener('input', this.update.bind(this))
    this.update()
  }

  update() {
    this.outputTarget.innerHTML = this.inputTarget.value.length
  }
}
