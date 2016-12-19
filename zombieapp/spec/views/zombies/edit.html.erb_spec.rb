require 'rails_helper'

RSpec.describe "zombies/edit", type: :view do
  before(:each) do
    @zombie = assign(:zombie, Zombie.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit zombie form" do
    render

    assert_select "form[action=?][method=?]", zombie_path(@zombie), "post" do

      assert_select "input#zombie_name[name=?]", "zombie[name]"
    end
  end
end
