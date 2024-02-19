class Stripe::CheckoutController < ApplicationController
  def pricing
    lookup_keys = %w[montly yearly]
    @prices = Stripe::Price.list(lookup_keys: lookup_keys, expand: ['data.product']).data.sort_by(&:unit_amount)
  end

  def checkout
    session = Stripe::Checkout::Session.create({
      mode: 'subscription',
      line_items: [{
        quantity: 1,
        price: params[:price_id]
      }],
      success_url: stripe_checkout_success_path,
      cancel_url: stripe_checkout_cancel_path,
      subscription_data: {
        trial_period_days: 30
      },
    })

    redirect_to session.url, allow_other_host: true
  end

  def success
    flash[:notice] = "Payment successful"
    redirect_to dashboard_index_path
  end

  def cancel
    flash[:error] = "Payment has been cancelled"
    redirect_to pricing_path
  end
end
