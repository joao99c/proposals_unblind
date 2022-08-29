import {Controller} from "@hotwired/stimulus"

var WebFont = require('webfontloader');

// Connects to data-controller="editor--slider--weight"
export default class extends Controller {
    static targets = ["fontInput", "weightInput", "spacingInput", "heightInput"];

    iframe = null
    target = "heading"

    connect() {
        this.iframe = document.querySelector("iframe");

        this.weightInputTarget.addEventListener("input", () => {
            this.change_weight()
        })

        this.spacingInputTarget.addEventListener("input", () => {
            this.change_spacing();
        })

        this.heightInputTarget.addEventListener("input", () => {
            this.change_height();
        })

        this.fontInputTarget.addEventListener("input", () => {
            this.limit_weights_select();
            this.change_font();
        })

        if(this.element.dataset.target){
            this.target = this.element.dataset.target
        }

        this.limit_weights_select();
    }

    limit_weights_select() {
        let selected = this.fontInputTarget.options[this.fontInputTarget.selectedIndex]
        let weights = JSON.parse(selected.dataset["weights"])

        for (let i = 0; i < this.weightInputTarget.options.length; i++) {
            this.weightInputTarget.options[i].disabled = !weights.includes(this.weightInputTarget.options[i].value)
        }

        this.weightInputTarget.querySelector('option:not([disabled])').selected = true
    }

    change_weight() {
        if (this.iframe) {
            let headings = null
            if (this.element.dataset.target === "heading")
                headings = this.iframe.contentDocument.querySelectorAll("#font-heading")
            if (this.element.dataset.target === "text")
                headings = this.iframe.contentDocument.querySelectorAll("#font-text")

            if (headings) {
                headings.forEach((item) => {
                    item.style.fontWeight = this.weightInputTarget.options[this.weightInputTarget.selectedIndex].value
                })
            }
        }
    }

    change_font() {
        let font_value = this.fontInputTarget.options[this.fontInputTarget.selectedIndex].innerText
        console.log(font_value)
        if (this.iframe) {
            let headings = null

            if (this.element.dataset.target === "heading")
                headings = this.iframe.contentDocument.querySelectorAll("#font-heading")
            if (this.element.dataset.target === "text")
                headings = this.iframe.contentDocument.querySelectorAll("#font-text")


            if (headings) {
                WebFont.load({
                    google: {
                        families: [`${font_value}:100,200,300,400,500,600,700,800,900`]
                    },
                    context: this.iframe.contentWindow,
                    fontactive: function () {
                        console.log("Font Loaded!")
                        headings.forEach((item) => {
                            item.style.fontFamily = font_value
                        })
                    }
                });
            }
        }
    }

    change_spacing() {
        if (this.iframe) {
            let headings = null
            if (this.element.dataset.target === "heading")
                headings = this.iframe.contentDocument.querySelectorAll("#font-heading")
            if (this.element.dataset.target === "text")
                headings = this.iframe.contentDocument.querySelectorAll("#font-text")

            if (headings) {
                headings.forEach((item) => {
                    item.style.letterSpacing = `${this.spacingInputTarget.value}em`
                })
            }
        }
    }

    change_height() {
        if (this.iframe) {

            let headings = null
            if (this.element.dataset.target === "heading")
                headings = this.iframe.contentDocument.querySelectorAll("#font-heading")
            if (this.element.dataset.target === "text")
                headings = this.iframe.contentDocument.querySelectorAll("#font-text")

            if (headings) {
                headings.forEach((item) => {
                    item.style.lineHeight = this.heightInputTarget.value
                })
            }
        }
    }
}
