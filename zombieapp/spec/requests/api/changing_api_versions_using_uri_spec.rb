require 'rails_helper'

module API
  describe "Changing API versions using URI" do
    let(:ip){ '123.123.12.12' }

    context "v1" do
      it "returns the version 1" do
        get 'http://api.example.com/v1/zombies', {}, {'REMOTE_ADDR' => ip}

        expect(response).to have_http_status(200)
        expect(response.body).to eq("#{ip} Version ONE")
      end
    end

    context "v2" do
      it "returns the version 2" do
        get 'http://api.example.com/v2/zombies', {}, {'REMOTE_ADDR' => ip}

        expect(response).to have_http_status(200)
        expect(response.body).to eq("#{ip} Version TWO")
      end

      it "audits logging" do
        expect_any_instance_of(API::V2::ZombiesController).to receive(:audit_logging_for_v2)
        get 'http://api.example.com/v2/zombies', {}, {'REMOTE_ADDR' => ip}
      end
    end
  end
end
