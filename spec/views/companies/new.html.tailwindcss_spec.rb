require 'rails_helper'

RSpec.describe "companies/new", type: :view do
  before(:each) do
    assign(:company, Company.new(
      name: "MyString",
      description: "MyText",
      email: "MyString",
      user: nil
    ))
  end

  it "renders new company form" do
    render

    assert_select "form[action=?][method=?]", companies_path, "post" do

      assert_select "input[name=?]", "company[name]"

      assert_select "textarea[name=?]", "company[description]"

      assert_select "input[name=?]", "company[email]"

      assert_select "input[name=?]", "company[user_id]"
    end
  end
end
