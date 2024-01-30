require 'rails_helper'

RSpec.describe("Invoices", type: :request) do
  before do
    @user = FactoryBot.create(:user)
    @company = FactoryBot.create(:company, user_id: @user.id)
    sign_in(@user)
  end

  describe "/index" do
    it "GET - should show that the invoice page has a title" do
      get company_invoices_path(@company)

      # expect the invoice page to be successful
      expect(response).to(be_successful)
      expect(response.body).to(include("Invoices"))
    end
  end

  describe "/new" do
    it "GET - should be able to render new invoice page" do
      get new_company_invoice_path(@company)
      expect(response).to(render_template(:new))
    end

    it "POST - should be able to create an invoice" do
      get new_company_invoice_path(@company)
      expect(response).to(render_template(:new))

      # create the invoice
      invoice_params = FactoryBot.attributes_for(:invoice, company_id: @company.id)
      post company_invoices_path(@company), params: { invoice: invoice_params }

      invoice = Invoice.first

      # redirect to the invoice
      expect(response).to(have_http_status(:redirect))
      follow_redirect!
      
      # render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include("Invoice was successfully created"))

      # testing invoice data
      # expect(response.body).to(include(invoice_params[:invoice_issue]))
      # expect(response.body).to(include(invoice_params[:customer]))
      # expect(response.body).to(include(invoice_params[:customer_address]))
    end
  end
end

