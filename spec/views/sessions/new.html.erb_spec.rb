require 'rails_helper'

RSpec.describe "sessions/new", type: :view do
  before(:each) do
    assign(:session, Session.new(
      :camp_configuration => nil,
      :description => "MyString",
      :active => false
    ))
  end

  it "renders new session form" do
    render

    assert_select "form[action=?][method=?]", sessions_path, "post" do

      assert_select "input[name=?]", "session[camp_configuration_id]"

      assert_select "input[name=?]", "session[description]"

      assert_select "input[name=?]", "session[active]"
    end
  end
end
