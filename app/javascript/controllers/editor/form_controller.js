import { Controller } from "@hotwired/stimulus"

import {
  PageSectionChangeEvent,
  buildNestedObject,
  elementToObject,
} from "./events";

// Connects to data-controller="editor--form"
export default class FormController extends Controller {
  connect() {
    this.listenForChanges();
  }

  listenForChanges() {
    this.listenForChange("input:not([type='file'])", "input");
    this.listenForChange("input[type='checkbox']", "change");
    this.listenForChange("trix-editor", "trix-change");
    this.listenForChange("select:not([data-autosave='false'])", "change");
    this.listenForChange("textarea", "input");
  }

  listenForChange(selector, eventType) {
    this.element.querySelectorAll(selector).forEach((element) => {
      element.addEventListener(eventType, () => this.dispatchEvent(element));
    });
  }

  dispatchEvent(element) {
    this.element.dispatchEvent(
        PageSectionChangeEvent(this.sectionId, this.changeset(element))
    );
  }

  dispatchUploaderEvent(event) {
    const key = event.target.dataset.key;

    const { file } = event.detail;
    const value = file.wistiaId ? file.wistiaId : file.preview;

    this.element.dispatchEvent(
        PageSectionChangeEvent(this.sectionId, buildNestedObject(key, value))
    );
  }

  changeset(element) {
    return elementToObject(element);
  }

  get sectionId() {
    return this.data.get("parentId") || this.data.get("id");
  }
}

