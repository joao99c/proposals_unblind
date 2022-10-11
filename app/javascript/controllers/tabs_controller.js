import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
    static targets = ["tabHeader"]

    connect() {
        let defaultTabId = null

        let tabElements = []
        this.tabHeaderTargets.forEach(th => {
            tabElements.push(
                {
                    id: th.id,
                    triggerEl: th,
                    targetEl: document.querySelector(`#${th.getAttribute("aria-controls")}`)
                }
            )

            if (th.getAttribute("aria-selected") === "true") {
                defaultTabId = th.id
            }
        })

        let options = {}
        if (defaultTabId) {
            options = {defaultTabId: `${defaultTabId}`}
        }


        console.log(options)
        const tabs = new Tabs(tabElements, options);

    }
}
