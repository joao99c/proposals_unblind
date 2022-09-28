import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="accordion"
export default class extends Controller {
    static targets = ["item"];

    connect() {
        console.log("accordion connected")
        let accordionItems = []
        this.itemTargets.forEach(i => {
            accordionItems.push(
                {
                    id: i.id,
                    triggerEl: i,
                    targetEl: document.querySelector(`#${i.getAttribute("aria-controls")}`),
                    active: false
                }
            )
        })
        console.log(accordionItems)
        // options with default values
        const options = {
            alwaysOpen: false,
            activeClasses: this.element.dataset.activeClasses ? this.element.dataset.activeClasses : 'bg-gray-100 dark:bg-gray-800 text-gray-900 dark:text-white',
            inactiveClasses: this.element.dataset.inactiveClasses ? this.element.dataset.inactiveClasses : 'text-gray-500 dark:text-gray-400',
            onOpen: (item) => {
                console.log('accordion item has been shown');
                console.log(item);
            },
            onClose: (item) => {
                console.log('accordion item has been hidden');
                console.log(item);
            },
            onToggle: (item) => {
                console.log('accordion item has been toggled');
                console.log(item);
            },
        };

        const accordion = new Accordion(accordionItems, options);
    }
}
