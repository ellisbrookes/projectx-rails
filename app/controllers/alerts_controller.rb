import { Alerts } from "stimulus";

export default class extends Alerts {
  closeAlert() {
    this.element.style.display = "none";
  }
}