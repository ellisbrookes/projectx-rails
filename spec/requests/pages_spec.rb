require 'rails_helper'

RSpec.describe("Homepage", type: :request) do
  describe "GET /index" do
    it "should show that the homepage has a title" do
      get root_path

      expect(response).to(be_successful)
      expect(response.body).to(include("Pages#home"))
    end
  end
end
