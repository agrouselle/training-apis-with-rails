require 'rails_helper'

module API
  describe "Episodes API" do
    before do
      host! 'api.example.com'
    end

    context "POST /episodes" do
      it "creates a new episode" do
        post '/episodes',
            { episode: {title: 'The Bananas', description: 'Learning about the bananas'} }.to_json,
            { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

        expect(response).to have_http_status(201)
        expect(response.content_type).to eq(Mime::JSON)

        episode = json(response.body)
        expect(response.location).to eq(api_episode_url(episode[:id]))
      end

      it "does not create an episode when title is nil" do
        post '/episodes',
             { episode: {title: nil, description: 'Learning about apples'} }.to_json,
             { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

        expect(response).to have_http_status(422)
        expect(response.content_type).to eq(Mime::JSON)
      end
    end

    context "PATCH /episodes/:id" do
      let(:episode){ Episode.create!(title: 'First title') }

      it "updates the episode" do
        patch "/episodes/#{episode.id}",
              { episode: { title:'First title edit' } }.to_json,
              { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

        expect(response).to have_http_status(200)
        expect(response.content_type).to eq(Mime::JSON)
        expect(episode.reload.title).to eq('First title edit')
      end

      it "does not update the episode with a title too short" do
        patch "/episodes/#{episode.id}",
              { episode: { title: 'short' } }.to_json,
              { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

        expect(response).to have_http_status(422)
        expect(response.content_type).to eq(Mime::JSON)
      end
    end

    context "DELETE /episodes/:id" do
      let(:episode){ Episode.create!(title: 'First title') }

      it "deletes the episode" do
        delete "/episodes/#{episode.id}"
        expect(response).to have_http_status(204)
      end
    end

    context "GET /episodes" do
      let(:user) { User.create!(username: 'foo', password:'secret') }

      context "with valid credentials" do
        it "gets the list of episodes" do
          get "/episodes", {}, {
              "Authorization" => encode_credentials(user.username, user.password),
              "Accept" => Mime::JSON
          }
          expect(response).to have_http_status(200)
        end
      end

      context "with missing credentials" do
        it "denies the access to the episodes" do
          get "/episodes", {}, {"Accept" => Mime::JSON}
          expect(response).to have_http_status(401)
        end
      end
    end

    context "GET /episodes/:id" do
      let(:episode){ Episode.create!(title: 'First title') }
      let(:user) { User.create! }

      context "with a valid token" do
        it "gets the episode" do
          get "/episodes/#{episode.id}", {}, {
              'Authorization' => token_header(user.auth_token),
              'Accept' => Mime::JSON
          }

          expect(response).to have_http_status(200)
          expect(response.content_type).to eq(Mime::JSON)
        end
      end

      context "with a bad token" do
        it "denies the access to the episode" do
          get "/episodes/#{episode.id}", {}, {'Accept' => Mime::JSON}

          expect(response).to have_http_status(401)
          expect(response.content_type).to eq(Mime::JSON)
        end
      end
    end
  end
end