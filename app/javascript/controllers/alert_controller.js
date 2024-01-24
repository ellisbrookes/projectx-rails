import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["closeAlert"]

  closeAlert() {
    this.closeAlertTarget.classList.add('animation-fadeOut');
    this.closeAlertTarget.style.display = "none";
  }
}