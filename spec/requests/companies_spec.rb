require 'rails_helper'

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

  describe "GET /new" do
    it "should be able to render new company page" do
      get new_company_path
      expect(response).to(render_template(:new))
    end
  end

  describe "POST /new" do
    it "should be able to create a company" do
      get new_company_path
      expect(response).to(render_template(:new))

      # create the company
      company_params = FactoryBot.attributes_for(:company)
      post companies_path, params: { company: company_params }

      # redirect to company
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include("Company was successfully created"))

      # testing company data
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
      expect(response.body).to(include("Email can&#39;t be blank"))
    end
  end

  describe "GET /edit" do
    before do
      @company = FactoryBot.create(:company, user_id: @user.id)
    end

    it "should be able to render the edit page" do
      get edit_company_path(@company)
      expect(response).to(render_template(:edit))
    end
  end

  describe "PUT /edit" do
    before do
      @company = FactoryBot.create(:company, user_id: @user.id)
    end

    it "should be able to update a company" do
      get edit_company_path(@company)
      expect(response).to(render_template(:edit))

      # update email
      new_email = Faker::Internet.email
      company_params = { company: { email: new_email } }
      put company_path(@company), params: company_params

      # redirect to company
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include(new_email))
      expect(response.body).to(include("Company was successfully updated"))
    end

    it "should not be able to update a company" do
      get edit_company_path(@company)
      expect(response).to(render_template(:edit))

      # update company without an email
      company_params = FactoryBot.attributes_for(:company, email: "")
      put company_path(@company), params: { company: company_params }

      # render error message
      expect(response).to(have_http_status(:unprocessable_entity))

      # render company edit page
      expect(response).to(render_template(:edit))
      expect(response.body).to(include("Email can&#39;t be blank"))
    end
  end

  describe "DELETE /show" do
    it "should be able to delete a company" do
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
      expect(response.body).to(include("Company was successfully destroyed"))
    end
  end
end
