require 'rails_helper'

RSpec.describe("Items", type: :request) do
  before do
    @user = FactoryBot.create(:user)
    @company = FactoryBot.create(:company, user_id: @user.id)
    @invoice = FactoryBot.create(:invoice, company_id: @company.id)
    sign_in(@user)
  end

  describe "/index" do
    it "GET - should show that the items page has a tite" do
      get company_items_path(@company)

      # expect the items page to be successfully
      expect(response).to(be_successful)
      expect(response.body).to(include("Items"))
    end
  end

  describe "/new" do
    it "GET - should be able to render new items page" do
      get new_company_item_path(@company)
      expect(response).to(render_template(:new))
    end

    it "POST - should be able to create an item" do
      get new_company_item_path(@company)
      expect(response).to(render_template(:new))

      item_params = FactoryBot.attributes_for(:item, invoice_id: @invoice.id, company_id: @company.id)
      post company_items_path(@company), params: { item: item_params }

      item = Item.first

      # redirect to the item
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include("Item was successfully created"))

      # testing the data
      expect(response.body).to(include(item_params[:description]))
      expect(response.body).to(include(item.quantity.to_s))
      expect(response.body).to(include(item.unit_price.to_s))
      expect(response.body).to(include(item_params[:name]))
    end

    it "POST - should not be able to create an item" do
      get new_company_item_path(@company)
      expect(response).to(render_template(:new))

      # create an item without an name
      item_params = FactoryBot.attributes_for(:item, name: nil, invoice_id: @invoice.id, company_id: @company.id)
      post company_items_path(@company), params: { item: item_params }

      # redirect back to item
      expect(response).to(have_http_status(:unprocessable_entity))

      # render error message
      expect(response).to(render_template(:new))
      expect(response.body).to(include("Name can&#39;t be blank"))
    end
  end

  describe "/edit" do
    before do
      @item = FactoryBot.create(:item, company_id: @company.id, invoice_id: @invoice.id)
    end

    it "GET - should be able to render edit page of an item" do
      get edit_company_item_path(@company, @item)
      expect(response).to(render_template(:edit))
    end

    it "PUT - should be able update an item" do
      get edit_company_item_path(@company, @item)
      expect(response).to(render_template(:edit))

      # update item name
      new_name = Faker::Company.name.gsub(/[^0-9a-zA-Z\s]/, '')
      item_params = { item: { name: new_name } }
      put company_item_path(@company, @item), params: item_params

      # redirect to the item
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include(new_name))
      expect(response.body).to(include("Item was successfully updated"))
    end

    it "PUT - should not be able to update a item" do
      get edit_company_item_path(@company, @item)
      expect(response).to(render_template(:edit))

      # update an item withut a name
      item_params = { item: { name: nil } }
      put company_item_path(@company, @item), params: item_params

      # render error message
      expect(response).to(have_http_status(:unprocessable_entity))

      # render the edit page
      expect(response).to(render_template(:edit))
      expect(response.body).to(include("Name can&#39;t be blank"))
    end
  end
end