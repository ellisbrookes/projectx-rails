require 'rails_helper' RSpec.describe("PagesController", type: :controller) do
describe "GET /index" do context "Homepage" do it "renders the homepage" do
expect(response).to(have_http_status(200)) end end end end
