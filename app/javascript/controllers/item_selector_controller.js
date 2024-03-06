import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="customer-selector"
export default class extends Controller {
  static targets = ["companyId", "itemId", "description"];

  connect() {
    this.element.addEventListener("change", this.onChange.bind(this));
    this.load();
  }

  load() {
    this.fetchData();
  }

  fetchData() {
    let companyId = this.companyIdTarget.value;
    let itemId = this.itemIdTarget.value;

    console.log(itemId.value);

    if (companyId && itemId) {
      fetch(
        `fetch("/dashboard/companies/${companyId}/items/${itemId}/load_data")`,
      )
        .then((res) => res.json())
        .then((data) => {
          console.log(data);
          this.ItemIdTarget.value = data.description;
        })
        .catch((e) => {
          console.error("Error:", e);
        });
    }
  }

  onChange() {
    this.load();
  }
}
