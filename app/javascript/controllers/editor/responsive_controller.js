import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="editor--responsive"
export default class extends Controller {
    static targets = ["button", "preview"];

    resize(event) {
        event.preventDefault();
        this.buttonTargets.forEach((button) => {
            if (button === event.currentTarget) {
                button.classList.add("bg-gray-200", "rounded");
            } else {
                button.classList.remove("bg-gray-200", "rounded");
            }
        });

        let class_name = ""
        switch (event.currentTarget.dataset.breakpoint) {
            case "mobile":
                class_name = "max-w-screen-xs"
                break;
            case "tablet":
                class_name = "max-w-screen-md"
                break;
            case "desktop":
                class_name = "max-w-[100%]"
                break;
        }

        this.previewTarget.classList.remove("max-w-screen-xs", "max-w-screen-md", "max-w-[100%]")

        // Add the class array to the class attribute
        this.previewTarget.classList.add(class_name)
        return false;
    }
}
