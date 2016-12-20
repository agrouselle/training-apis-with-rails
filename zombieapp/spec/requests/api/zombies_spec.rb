require 'rails_helper'

module API
  describe "Zombies API" do
    before do
      host! 'api.example.com'
    end

    context "GET /zombies" do
      it "returns zombies" do
        get api_zombies_url
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end

      it "returns zombies filtered by weapon" do
        z1 = FactoryGirl.create(:zombie, name:"Zombie 1", weapon:"axe")
        z2 = FactoryGirl.create(:zombie, name:"Zombie 2", weapon:"shotgun")

        get api_zombies_url(weapon:'axe')
        expect(response).to have_http_status(200)
        expect(response.body).to be_present

        zombies = json(response.body)
        zombies_name = zombies.collect {|z| z[:name]}

        expect(zombies_name).to include(z1.name)
        expect(zombies_name).not_to include(z2.name)
      end

      context "when requesting JSON" do
        it "returns zombies in JSON format" do
          get api_zombies_url, {}, {'Accept' => Mime::JSON}

          expect(response).to have_http_status(200)
          expect(response.content_type).to eq(Mime::JSON)
        end
      end

      context "when requesting XML" do
        it "returns zombies in XML format" do
          get api_zombies_url, {}, {'Accept' => Mime::XML}

          expect(response).to have_http_status(200)
          expect(response.content_type).to eq(Mime::XML)
        end
      end

      # context "when requesting in English" do
      #   it "returns zombies in English" do
      #     get api_zombies_url, {}, {''}
      #   end
      # end
      #
      # context "when requesting in French" do
      #   it "returns zombies in French" do
      #
      #   end
      # end
    end

    context "GET /zombies/:id" do
      it "returns the requested zombie" do
        z = FactoryGirl.create(:zombie)

        get api_zombie_url(z.id)
        expect(response).to have_http_status(200)
        expect(response.body).to be_present

        zombie_response = json(response.body)
        expect(zombie_response[:name]).to eq(z.name)
      end
    end




  end
end

