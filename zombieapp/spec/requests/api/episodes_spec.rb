require 'rails_helper'

module API
  describe "Episodes API" do
    before do
      host! 'api.example.com'
    end

    context "POST /episodes" do
      it "creates a new episode" do
        post '/episodes',
            { episode: {title: 'Bananas', description: 'Learning about bananas'} }.to_json,
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
  end
end