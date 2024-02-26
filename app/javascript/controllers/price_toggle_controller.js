import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ["monthly", "yearly"];

  showMonthly() {
    this.monthlyTarget.classList.remove("hidden");
    this.yearlyTarget.classList.add("hidden");
  }

  showYearly() {
    this.monthlyTarget.classList.add("hidden");
    this.yearlyTarget.classList.remove("hidden");
  }
}
