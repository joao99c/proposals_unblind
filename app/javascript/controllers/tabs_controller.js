import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
    static targets = ["tabHeader"]

    connect() {
        let tabElements = []
        this.tabHeaderTargets.forEach(th => {
            tabElements.push(
                {
                    id: th.id,
                    triggerEl: th,
                    targetEl: document.querySelector(`#${th.getAttribute("aria-controls")}`)
                }
            )
        })

        const tabs = new Tabs(tabElements);

    }
}
