import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="item-selector"
export default class extends Controller {
  connect() {
    console.log("hello from stimulus!");
  }

  load(event) {
    let companyId = this.data.get("companyId");
    let itemId = event.target.value;

    if (companyId && itemId) {
      fetch("/dashboard/company/${companyId}/items/${itemId}/load_data")
        .then((res) => res.text())
        .then((html) => {
          this.targets.find("data-target").innerHTML = html;
        })
        .catch((e) => {
          console.error("Error", e);
        });
    }
  }

  // Access the company ID from the data attribute
  get companyId() {
    return this.data.get("companyId");
  }
}
