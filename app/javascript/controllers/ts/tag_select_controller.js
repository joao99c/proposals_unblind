import {Controller} from "@hotwired/stimulus"
import TomSelect from "tom-select"

// Connects to data-controller="ts--select"
export default class extends Controller {
    connect() {
        // get options from data-options attribute
        let select_options = []
        let selected_options = []

        if (this.element.dataset.items) {
            let aux = JSON.parse(this.element.dataset.items)
            console.log(aux)
            for (let i = 0; i < aux.length; i++) {
                selected_options.push(aux[i])
            }
        }

        if (this.element.dataset.options) {
            let aux = JSON.parse(this.element.dataset.options)
            for (let i = 0; i < aux.length; i++) {
                let item = aux[i]
                select_options.push(
                    {
                        text: item[0],
                        text_color: item[1],
                        background_color: item[2],
                        id: item[3],
                    }
                )
            }
        }


        // each item contains name, color and id


        new TomSelect(this.element, {
                plugins: {
                    remove_button: {
                        title: 'Remove this item',
                    }
                },
                onItemAdd: function (e) {
                    this.setTextboxValue('');
                    this.refreshOptions();
                },
                persist: false,
                create: function (input, callback) {
                    const data = {name: input}
                    const token = document.querySelector('meta[name="csrf-token"]').content
                    fetch('/admin/tags', {
                        method: 'POST',
                        headers: {
                            "X-CSRF-Token": token,
                            "Content-Type": "application/json",
                            "Accept": "application/json"
                        },
                        body: JSON.stringify(data)
                    })
                        .then((response) => {
                            return response.json();
                        })
                        .then((data) => {
                            callback({
                                id: data.id,
                                text: data.name,
                                text_color: data.text_color,
                                background_color: data.background_color
                            })
                        });
                },
                render: {
                    option: function (data, escape) {
                        return '<div class="!bg-' + data.background_color + ' !text-' + data.text_color + ' text-xs font-semibold rounded">' + escape(data.text) + '</div>';
                    },
                    item: function (data, escape) {
                        return '<div class="!bg-' + data.background_color + ' !text-' + data.text_color + ' text-xs font-semibold !m-1 h-10 rounded">' + escape(data.text) + '</div>';
                    },
                    option_create: function (data, escape) {
                        return '<div class="create">Adicionar <strong>' + escape(data.input) + '</strong>&hellip;</div>';
                    },
                    no_results: function (data, escape) {
                        return '<div class="no-results">Não foram encontrados resultados para "' + escape(data.input) + '"</div>';
                    },
                },
                valueField: 'id',
                options: select_options,
                items: selected_options,
            }
        )
    }

}
