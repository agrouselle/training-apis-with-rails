require 'rails_helper'

module API
  describe "Changing API versions using Accept header" do
    let(:ip){ '123.123.12.12' }

    context "v1" do
      it "returns the version 1" do
        get 'http://api.example.com/vampires', {}, {'Accept' => 'application/vnd.apocalypse.v1+json', 'REMOTE_ADDR' => ip}

        expect(response).to have_http_status(200)
        expect(response.body).to eq("#{ip} Vampire Version ONE")
        expect(response.content_type).to eq(Mime::JSON)
      end
    end

    context "v2" do
      it "returns the version 2" do
        get 'http://api.example.com/vampires', {}, {'Accept' => 'application/vnd.apocalypse.v2+json', 'REMOTE_ADDR' => ip}

        expect(response).to have_http_status(200)
        expect(response.body).to eq("#{ip} Vampire Version TWO")
        expect(response.content_type).to eq(Mime::JSON)
      end
    end
  end
end