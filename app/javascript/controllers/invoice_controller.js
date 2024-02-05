import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js"

// Connects to data-controller="invoice"
export default class extends Controller {
  static targets = ["customerAddress"];

  handleChange(event) {
    let company = document.querySelector("input[name='invoice[company_id]'").value;
    let customer = event.target.selectedOptions[0].value;
    let target = this.customerAddressTarget.id

    // get the customer details
    get(`/dashboard/companies/${company}/customers/${customer}?target=${target}`, {
      responseKind: "turbo-stream",
    })
  }
}
