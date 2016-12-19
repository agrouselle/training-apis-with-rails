require 'rails_helper'

RSpec.describe "zombies/index", type: :view do
  before(:each) do
    assign(:zombies, [
      Zombie.create!(
        :name => "Name"
      ),
      Zombie.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of zombies" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
