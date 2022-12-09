import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="textarea--autosize"
export default class extends Controller {
    connect() {
        this.element.addEventListener('input', this.resize.bind(this));
        this.resize();
    }

    resize() {
        console.log('resize')
        this.element.style.height = 'auto';
        this.element.style.height = this.element.scrollHeight + 'px';
    }
}
