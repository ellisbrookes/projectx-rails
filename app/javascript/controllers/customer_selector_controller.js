import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="customer-selector"
export default class extends Controller {
  static targets = ["customerId", "companyId", "address", "notes"];

  connect() {
    this.element.addEventListener("change", this.onChange.bind(this));
    this.load();
  }

  load() {
    this.fetchData();
  }

  fetchData() {
    let companyId = this.companyIdTarget.value;
    let customerId = this.customerIdTarget.value;

    if (companyId && customerId) {
      fetch(
        `/dashboard/companies/${companyId}/customers/${customerId}/load_data`,
      )
        .then((res) => res.json())
        .then((data) => {
          this.addressTarget.value = data.address;
          this.notesTarget.value = data.notes;
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
