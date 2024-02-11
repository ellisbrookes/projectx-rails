import { Controller } from "@hotwired/stimulus";
import { post } from "@rails/request.js";

function initialize() {}

export default class extends Controller {
  static values = { publishableKey: String, url: String };

  async connect() {
    try {
      const stripe = stripe(this.publishableKeyValue);
      const response = await post(this.urlValue);
      const { clientSecret } = await response.json();
      
      const checkout = await stripe.initEmbeddedCheckout({
        clientSecret,
      });
      
      checkout.mount(this.element);
    } catch (error) {
      console.error(error.message);
      // Handle error gracefully
    }
  }
}
