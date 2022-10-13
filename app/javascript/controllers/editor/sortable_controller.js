import {Controller} from "@hotwired/stimulus"
import Sortable from "sortablejs";

// Connects to data-controller="editor--sortable"
export default class extends Controller {
    connect() {
        this.sortable = Sortable.create(this.element, {
            onEnd: this.end.bind(this)
        })
    }

    end(e) {
        let id = e.item.dataset.id;
        let data = new FormData();
        let position = e.newIndex + 2
        data.append("position", position); // Start at 0; 1 is always the heading
        const token = document.querySelector('meta[name="csrf-token"]').content
        fetch(this.data.get('url').replace(':id', id), {
            method: 'PATCH',
            headers: {
                "X-CSRF-Token": token,
            },
            body: data
        }).then(response => {
            if (response.ok) {
                this.reorder_preview(e);
            }
        });
    }

    reorder_preview(event) {
        const eventPageSection = event.item
        const currentPageSection = document.querySelector("iframe").contentDocument.querySelector("#" + eventPageSection.dataset.previewId).parentElement;
        const parentNode = currentPageSection.parentNode;

        if (event.newIndex > event.oldIndex) {
            parentNode.insertBefore(currentPageSection, parentNode.children[event.newIndex + 2]);
        } else {
            parentNode.insertBefore(currentPageSection, parentNode.children[event.newIndex + 1]);
        }
        window.scrollTo({
            top: currentPageSection.offsetTop,
            behavior: "smooth",
        });

    }
}
