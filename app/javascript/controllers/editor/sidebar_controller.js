import {Controller} from "@hotwired/stimulus";

// Connects to data-controller="this.sidebarTarget"
export default class extends Controller {
    static targets = ["sidebar"];

    connect() {
        if (this.sidebarTargets.length > 0) {
            const toggleSidebarEl = this.element.querySelectorAll("#toggleSidebar");

            // initialize this.sidebarTarget
            if (localStorage.getItem("sidebarExpanded") !== null) {
                if (localStorage.getItem("sidebarExpanded") === "true") {
                    this.toggleSidebar(this.sidebarTarget, true, false);
                } else {
                    this.toggleSidebar(this.sidebarTarget, false, true, toggleSidebarEl);
                }
            }
        }
    }

    toggle(e) {
        localStorage.setItem(
            "sidebarExpanded",
            !this.isSidebarExpanded(e.currentTarget)
        );
        this.toggleSidebar(this.sidebarTarget, !this.isSidebarExpanded(e.currentTarget), true, e.currentTarget);
    }

    show(e) {
        localStorage.setItem("sidebarExpanded", true);
        this.toggleSidebar(this.sidebarTarget, true, true, e.currentTarget);
    }

    toggleSidebar(sidebarEl, expand, setExpanded = false, toggleSidebarEl = null) {
        const mainContentEl = document.getElementById("main-content");
        if (expand) {
            sidebarEl.classList.add("lg:w-80");
            sidebarEl.classList.remove("hidden");
            mainContentEl.classList.add("lg:ml-80");
        } else {
            sidebarEl.classList.remove("lg:w-80");
            sidebarEl.classList.add("hidden");
            mainContentEl.classList.remove("lg:ml-80");
        }

        if (setExpanded && toggleSidebarEl !== null) {
            toggleSidebarEl.setAttribute("aria-expanded", expand);
        }
    };

    isSidebarExpanded(toggleSidebarEl) {
        return toggleSidebarEl.getAttribute("aria-expanded") === "true";
    };
}
