import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ["fields", "template"];

  connect() {
    this.index = 0;
  }

  addField(event) {
    console.log("Adding field...");

    const newFields = this.templateTarget.innerHTML.replace(/NEWINDEX/g, this.index);
    const wrapper = document.createElement('div');
    wrapper.innerHTML = newFields;
    this.fieldsTarget.appendChild(wrapper);

    this.index++;
  }
}
