require 'rails_helper'
require 'cgi'

RSpec.describe("Companies", type: :request) do
  before do
    @user = FactoryBot.create(:user)
    sign_in(@user)
  end

  describe "GET /index" do
    it "should show that the company page has a title" do
      get companies_path

      # expect the index page to include the word companies 
      expect(response).to(be_successful)
      expect(response.body).to(include("Companies"))
    end
  end

  describe "POST /new" do
    it "Should be able to render new company page" do
      get new_company_path
      expect(response).to(render_template(:new))
    end

    it "Should be able to create a company" do
      get new_company_path
      expect(response).to(render_template(:new))

      # Create the company
      company_params = FactoryBot.attributes_for(:company)
      post companies_path, params: { company: company_params }

      # Redirect to company
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # Render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include("Company was successfully created."))

      # Testing company data
      expect(response.body).to(include(company_params[:name]))
      expect(response.body).to(include(company_params[:description]))
      expect(response.body).to(include(company_params[:email]))
    end

    it "should not be able to create a company" do
      get new_company_path
      expect(response).to(render_template(:new))

      # create company without an email
      company_params = FactoryBot.attributes_for(:company, email: "")
      post companies_path, params: { company: company_params }

      # render error message
      expect(response).to(have_http_status(:unprocessable_entity))

      # render company new page
      expect(response).to(render_template(:new))

      # render error message saying email can't be blank
      expect(response.body).to(include("Email can&#39;t be blank"))
    end
  end

  describe "PUT /edit" do
    it "Should be able to update a company" do
      @company = FactoryBot.create(:company, user_id: @user.id)
      get edit_company_path(@company)
      expect(response).to(render_template(:edit))

      # update email
      new_email = Faker::Internet.email
      company_params = { company: { email: new_email }}
      patch company_path(@company), params: company_params 
      
      # Redirect to company
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # Render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include(new_email))
      expect(response.body).to(include("Company was successfully updated."))
    end
  end

  describe "DELETE /show" do
    it "Should be able to delete a company" do
      @company = FactoryBot.create(:company, user_id: @user.id)
      get company_path(@company)
      expect(response).to(render_template(:show))

      # delete company
      delete company_path(@company)

      # redirect to company
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # redirect to index page
      expect(response).to(render_template(:index))
      expect(response.body).to(include("Company was successfully destroyed."))
    end
  end
end
