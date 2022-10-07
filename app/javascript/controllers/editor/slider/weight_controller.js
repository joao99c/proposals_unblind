import {Controller} from "@hotwired/stimulus"

var WebFont = require('webfontloader');

// Connects to data-controller="editor--slider--weight"
export default class extends Controller {
    static targets = ["fontInput", "weightInput", "spacingInput", "heightInput", "buttonBackground", "buttonBorder", "buttonBorderWidth", "buttonBorderRadius"];

    iframe = null
    target = "heading"

    connect() {
        console.log("wheight connected")
        this.iframe = document.querySelector("iframe");


        if (this.hasWeightInputTarget) {
            this.weightInputTarget.addEventListener("input", () => {
                this.change_weight()
            })

        }
        if (this.hasSpacingInputTarget) {
            this.spacingInputTarget.addEventListener("input", () => {
                this.change_spacing();
                this.change_button();

            })

        }
        if (this.hasHeightInputTarget) {
            this.heightInputTarget.addEventListener("input", () => {
                this.change_height();
            })

        }
        if (this.hasFontInputTarget) {
            this.fontInputTarget.addEventListener("input", () => {
                this.limit_weights_select();
                this.change_font();
            })
        }


        if (this.hasButtonBackgroundTarget) {
            this.buttonBackgroundTarget.addEventListener("input", () => {
                console.log("chaging button: ", this.buttonBackgroundTarget)
                this.change_button();
            })

        }

        if (this.hasButtonBorderTarget) {
            this.buttonBorderTarget.addEventListener("input", () => {
                console.log("chaging button: ", this.buttonBorderTarget)
                this.change_button();
            })

        }

        if (this.hasButtonBorderWidthTarget) {
            this.buttonBorderWidthTarget.addEventListener("change", () => {
                console.log("chaging button: ", this.buttonBorderWidthTarget)
                this.change_button();
            })

        }

        if (this.hasButtonBorderRadiusTarget) {
            this.buttonBorderRadiusTarget.addEventListener("change", () => {
                console.log("chaging button: ", this.buttonBorderRadiusTarget)
                this.change_button();
            })

        }

        if (this.element.dataset.target) {
            this.target = this.element.dataset.target
        }

        if (this.hasFontInputTarget && this.hasWeightInputTarget) {
            this.limit_weights_select();
        }
    }

    limit_weights_select() {
        let selected = this.fontInputTarget.options[this.fontInputTarget.selectedIndex]
        let weights = JSON.parse(selected.dataset["weights"])

        for (let i = 0; i < this.weightInputTarget.options.length; i++) {
            this.weightInputTarget.options[i].disabled = !weights.includes(this.weightInputTarget.options[i].value)
        }

        let weightSelected = this.weightInputTarget.options[this.weightInputTarget.selectedIndex]
        if (weightSelected.disabled)
            this.weightInputTarget.querySelector('option:not([disabled])').selected = true
    }

    change_weight() {
        if (this.iframe) {
            let headings = this.get_items()

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
            let headings = this.get_items()

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
            let headings = this.get_items()

            if (headings) {
                headings.forEach((item) => {
                    item.style.letterSpacing = `${this.spacingInputTarget.value}em`
                })
            }
        }
    }

    change_height() {
        if (this.iframe) {
            let headings = this.get_items()

            if (headings) {
                headings.forEach((item) => {
                    item.style.lineHeight = this.heightInputTarget.value
                })
            }
        }
    }

    change_button() {
        console.log("changing button")
        if (this.iframe) {
            let headings = this.get_items()
            if (headings) {
                headings.forEach((item) => {
                    item.style.backgroundColor = this.buttonBackgroundTarget.value
                    item.style.borderColor = this.buttonBorderTarget.value
                    item.style.borderWidth = this.buttonBorderWidthTarget.value
                    item.style.borderRadius = this.buttonBorderRadiusTarget.value
                })
            }
        }
    }

    get_items() {
        if (this.element.dataset.target === "heading")
            return this.iframe.contentDocument.querySelectorAll(".deal-font-heading")

        if (this.element.dataset.target === "section_heading")
            return this.iframe.contentDocument.querySelectorAll(".deal-font-section-heading")

        if (this.element.dataset.target === "sub_section_heading")
            return this.iframe.contentDocument.querySelectorAll(".deal-font-sub-section-heading")

        if (this.element.dataset.target === "text")
            return this.iframe.contentDocument.querySelectorAll(".deal-font-text")

        if (this.element.dataset.target === "link")
            return this.iframe.contentDocument.querySelectorAll(".deal-font-link")

        if (this.element.dataset.target === "button")
            return this.iframe.contentDocument.querySelectorAll(".deal-font-button")
    }
}
