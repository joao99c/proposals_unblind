import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = []

  elements = null;
  submitButton = null;

  initialize() {
    // Get submit button
    // Determine if submit button should be disabled
    // Add event listeners to all inputs, selects, and textareas
    // If any of the inputs, selects, or textareas change, run validate

    console.log("initialize")

    this.submitButton = this.element.querySelectorAll("*[type='submit']")
    if (this.submitButton) {
      // get all inputs that are not submit buttons and not inside .trix-container, select, textarea, trix-editor
      this.elements = this.element.querySelectorAll("input:not([type='submit']):not(.trix-input):not(.trix-content):not(.trix-editor), select, textarea, trix-editor");
      // remove file inputs
        this.elements = Array.from(this.elements).filter((element) => {return element.type !== "file"})
      for (let i = 0, iLen = this.elements.length; i < iLen; i++) {
        console.log(this.elements[i])
        console.log(this.elements[i].value)
        this.elements[i].addEventListener('change', () => this.validate());
        this.elements[i].addEventListener('keyup', () => this.validate());
      }
    }
    // this.validate()

  }

  validate() {
    var inputsWithValues = 0;
    // loop through all inputs and add up all the ones that have a value
    for (let i = 0, iLen = this.elements.length; i < iLen; i++) {
      // if it has a value, increment the counter
      if (this.elements[i].value) {
        inputsWithValues += 1;
      }
    }

    // Disable all submit buttons if all inputs are empty
    for (let i = 0, iLen = this.submitButton.length; i < iLen; i++) {
      this.submitButton[i].disabled = inputsWithValues !== this.elements.length;
    }
  }

}
