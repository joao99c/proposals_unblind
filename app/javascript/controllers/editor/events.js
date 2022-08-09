export const buildNestedObject = (key, value) => {
    let result = {};
    let object = result;
    let arr = key.split(".");

    for (var i = 0; i < arr.length - 1; i++) {
        object = object[arr[i]] = {};
    }

    object[arr[arr.length - 1]] = value;

    return result;
};

const valueForElement = (element) => {
    if (element.type === "checkbox") {
        return element.checked;
    } else {
        return element.value;
    }
};

export const elementToObject = (element) => {
    return buildNestedObject(element.dataset.key, valueForElement(element));
};

export function PageSectionChangeEvent(id, changeset) {
    return new CustomEvent("editor:page-section:changed", {
        bubbles: true,
        detail: { id: id, changeset: changeset },
    });
}

export function StorefrontChangeEvent(changeset) {
    return new CustomEvent("editor:storefront:changed", {
        bubbles: true,
        detail: changeset,
    });
}
