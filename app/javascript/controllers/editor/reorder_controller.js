import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="editor--reorder"
export default class extends Controller {
    static targets = ["moveSectionButton"];

    connect() {
        console.log("editor--reorder connected");
        this.setStateOnMoveSectionButtons();

        const observer = new MutationObserver(() => {
            this.setStateOnMoveSectionButtons();
        });

        observer.observe(this.element, {
            childList: true,
        });
    }

    setStateOnMoveSectionButtons() {

        this.moveSectionButtonTargets
            .filter((element) => element.dataset["editor-PageSectionDirectionParam"] === "up")
            .forEach((element, index) => {
                if (index === 0) {
                    element.classList.add("pointer-events-none", "text-gray-500");
                    return;
                }

                element.classList.remove("pointer-events-none", "text-gray-500");
            });

        this.moveSectionButtonTargets
            .filter((element) => element.dataset["editor-PageSectionDirectionParam"] === "down")
            .forEach((element, index, array) => {
                if (index === array.length - 1) {
                    element.classList.add("pointer-events-none", "text-gray-500");
                    return;
                }

                element.classList.remove("pointer-events-none", "text-gray-500");
            });
    }
}
