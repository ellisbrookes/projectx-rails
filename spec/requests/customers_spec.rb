require 'rails_helper'

RSpec.describe("Customers", type: :request) do
  before do
    @user = FactoryBot.create(:user)
    @company = FactoryBot.create(:company, user_id: @user.id)
    sign_in(@user)
  end

  describe "/index" do
    it "GET - should show that the customer page has a title" do
      get company_customers_path(@company)

      # expect the index page to include the word customers
      expect(response).to(be_successful)
      expect(response.body).to(include("Customers"))
    end
  end

  describe "/new" do
    it "GET - should be able to render the new customers page" do
      get new_company_customer_path(@company)

      # expect the index page to be successfully
      expect(response).to(be_successful)
      expect(response.body).to(include("New Customer"))
    end

    it "POST - should be able to create a customer" do
      get new_company_customer_path(@company)
      expect(response).to(render_template(:new))

      # create the customer
      customer_params = FactoryBot.attributes_for(:customer, company_id: @company.id)
      post company_customers_path(@company, @customer), params: { customer: customer_params }

      customer = Customer.first

      # redirect to the customer
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include("Customer was successfully created"))

      # testing customer data
      expect(response.body).to(include(customer_params[:full_name]))
      expect(response.body).to(include(customer.address.to_s))
      expect(response.body).to(include(customer_params[:phone_number]))
      expect(response.body).to(include(customer_params[:email]))
      expect(response.body).to(include(customer_params[:notes]))
    end

    it "POST - should not able to create a customer" do
      get new_company_customer_path(@company)
      expect(response).to(render_template(:new))

      # create the customer without an address
      customer_params = FactoryBot.attributes_for(:customer, address: nil, company_id: @company.id)
      post company_customers_path(@company, @customer), params: { customer: customer_params }

      # render error message
      expect(response).to(have_http_status(:unprocessable_entity))

      # render customer new page
      expect(response).to(render_template(:new))
      expect(response.body).to(include("Address can&#39;t be blank"))
    end
  end

  describe "/edit" do
    before do
      @customer = FactoryBot.create(:customer, company_id: @company.id)
    end

    it "GET - should be able to render the edit page of a customer" do
      get edit_company_customer_path(@company, @customer)
      expect(response).to(render_template(:edit))
    end

    it "PUT - should be able to update a customer" do
      get edit_company_customer_path(@company, @customer)
      expect(response).to(render_template(:edit))

      # new addresss
      new_address = Faker::Address.full_address.gsub(/[^0-9a-zA-Z\s]/, '')
      customer_params = { customer: { address: new_address } }
      put company_customer_path(@company, @customer), params: customer_params

      # redirect to the customer
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include(new_address))
      expect(response.body).to(include("Customer was successfully updated"))
    end
  end

  describe "/delete" do
    before do
      @customer = FactoryBot.create(:customer, company_id: @company.id)
    end

    it "DELETE - should be able to delete a customer" do
      get company_customer_path(@company, @customer)
      expect(response).to(render_template(:show))

      # delete a customer
      delete company_customer_path(@company, @customer)

      # redirect to customer
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # redirect to the index page
      expect(response).to(render_template(:index))
      expect(response.body).to(include("Customer was successfully destroyed"))
    end
  end
end
