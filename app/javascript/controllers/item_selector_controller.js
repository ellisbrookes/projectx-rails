import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="customer-selector"
export default class extends Controller {
  static targets = ["companyId", "itemId", "description", "unitPrice"];

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

    if (companyId && itemId) {
      fetch(`/dashboard/companies/${companyId}/items/${itemId}/load_data`)
        .then((res) => res.json())
        .then((data) => {
          console.log(data);

          this.descriptionTarget.innerHTML = data.description.body;
          this.unitPriceTarget.innerHTML = data.unit_price;
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
