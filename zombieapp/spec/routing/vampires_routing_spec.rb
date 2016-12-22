require "rails_helper"

RSpec.describe ZombiesController, type: :routing do
  describe "routes versions" do
    it "routes to #index" do
      expect(:get => 'http://api.example.com/vampires').to route_to("api/v2/vampires#index", subdomain:'api', format: :json)
    end
  end
end
