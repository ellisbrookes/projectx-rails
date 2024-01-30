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
      expect(response.body).to(include(invoice_params[:invoice_issue].to_s))
      expect(response.body).to(include(invoice_params[:customer]))
      expect(response.body).to(include(invoice_params[:customer_address]))
      expect(response.body).to(include(invoice_params[:company_address]))
      expect(response.body).to(include(invoice.issue_date.strftime('%d/%m/%Y')))
      expect(response.body).to(include(invoice.due_date.strftime('%d/%m/%Y')))
      expect(response.body).to(include(invoice.amount.to_s))
      expect(response.body).to(include(invoice_params[:notes]))
    end

    it "POST - should not be able to create a invoice" do
      get new_company_invoice_path(@company)
      expect(response).to(render_template(:new))

      # create an invoice with an invoice_issue
      invoice_params = FactoryBot.attributes_for(:invoice, invoice_issue: nil, company_id: @company.id)
      post company_invoices_path(@company), params: { invoice: invoice_params }

      # redirect back to the invoice
      expect(response).to(have_http_status(:unprocessable_entity))

      # render error message
      expect(response).to(render_template(:new))
      expect(response.body).to(include("Invoice issue can&#39;t be blank<"))
    end
  end

  describe "/edit" do
    before do
      @invoice = FactoryBot.create(:invoice, company_id: @company.id)
    end

    it "GET - should be able to render edit page of a invoice" do
      get edit_company_invoice_path(@company, @invoice)
      expect(response).to(render_template(:edit))
    end

    it "PUT - should be able to update an invoice" do
      get edit_company_invoice_path(@company, @invoice)
      expect(response).to(render_template(:edit))

      # update customer name
      new_name = Faker::Company.name.gsub(/[^0-9a-zA-Z\s]/, '')
      invoice_params = { invoice: { customer: new_name } }
      put company_invoice_path(@company, @invoice), params: invoice_params

      # redirect to the invoice
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include(new_name))
      expect(response.body).to(include("Invoice was successfully updated"))
    end

    it "PUT - should not be able to update a invoice" do
      get edit_company_invoice_path(@company, @invoice)
      expect(response).to(render_template(:edit))

      # update a invoice without a customer name
      invoice_params = { invoice: { customer: nil } }
      put company_invoice_path(@company, @invoice), params: invoice_params

      # render error messsage
      expect(response).to(have_http_status(:unprocessable_entity))

      # render the edit page
      expect(response).to(render_template(:edit))
      expect(response.body).to(include("Customer can&#39;t be blank"))
    end
  end
end

