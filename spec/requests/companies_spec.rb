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

      expect(response).to(be_successful)
      expect(response.body).to(include("Companies"))
    end
  end

  describe "POST /new" do
    it "Should be able to render new company page" do
      get new_company_path
      expect(response).to render_template(:new)
    end

    it "Should be able to create a company" do
      get new_company_path
      expect(response).to render_template(:new)
      
      # Create the company
      company_params = FactoryBot.attributes_for(:company)
      post companies_path, params: { company: company_params }

      # Redirect to company
      expect(response).to have_http_status(:redirect)
      follow_redirect!

      # Render the show page
      expect(response).to render_template(:show)
      expect(response.body).to include("Company was successfully created.")
      
      # Testing company data
      expect(response.body).to include(company_params[:name])
      expect(response.body).to include(company_params[:description])
      expect(response.body).to include(company_params[:email])
    end

    it "should not be able to create a company" do
      get new_company_path
      expect(response).to render_template(:new)

      company_params = FactoryBot.attributes_for(:company, email: "")
      post companies_path, params: {company: company_params}

      expect(response).to have_http_status(:unprocessable_entity)

      expect(response).to render_template(:new)

      error_message = "Email can't be blank"
      decoded_error_message = CGI::unescapeHTML(error_message)
      expect(response.body).to include(decoded_error_message)
    end
  end
end
