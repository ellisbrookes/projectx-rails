import { Controller } from "@hotwired/stimulus";
import { post } from "@rails/request.js";

export default class extends Controller {
  static values = { publishableKey: String, url: String};
  async connect() {
    try {
      const stripe = Stripe(this.publishableKeyValue);
      const response = await post(this.urlValue);
      const { fetchClientSecret } = response.json;
      
      const checkout = await stripe.initEmbeddedCheckout({
        fetchClientSecret,
      });
      
      checkout.mount(this.element);
    } catch (error) {
      console.error(error.message);
      // Handle error gracefully
    }
  }
}
