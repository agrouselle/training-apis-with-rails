require 'rails_helper'

describe "Zombies" do
  describe "GET /zombies" do
    it "succeeds" do
      get zombies_path
      expect(response).to have_http_status(200)
    end
  end
end
