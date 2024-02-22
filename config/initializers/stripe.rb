if Rails.env.production?
  Stripe.api_key = Rails.application.credentials.dig(:stripe, :private_key)
else
  Stripe.api_key = "sk_test_51OhH4EHhcsFflMX4vt24rvEX2k1hGJTljUCCkBOySiOz00oSSRgdHErOvhcwz0tXA1j3UonoqYBqXY6n2CNYpdN000Qh1s6giW"
end
