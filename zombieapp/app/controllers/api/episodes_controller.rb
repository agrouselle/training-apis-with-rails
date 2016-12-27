module API
  class EpisodesController < ApplicationController
    before_action :authenticate, only: [:index]

    # Example of curl command to get the index action
    # curl -I -H "Accept: application/json" -u "foo:secret" http://api.localhost.com:3000/episodes
    def index
      render json: Episode.all, status: 200
    end

    def create
      episode = Episode.new(episode_params)
      if episode.save
        render json: episode, status: 201, location: api_episode_url(episode.id)

        # To respond successfully but without content
        # render nothing: true, status: 204, location: api_episode_url(episode.id)
        # or
        # head 204, location: episode

      else
        render json: episode.errors, status: 422
      end
    end

    def update
      episode = Episode.find(params[:id])
      if episode.update(episode_params)
        render json: episode, status: 200
      else
        render json: episode.errors, status: 422
      end
    end

    def destroy
      Episode.destroy(params[:id])
      head 204
    end

    protected

    def authenticate
      # Reads and decodes username and password from Authorization header
      # Defines the realm as 'Episodes' in the response
      # Halts the request and responds with text/html content type
      # authenticate_or_request_with_http_basic('Episodes') do |username, password|
      #   User.authenticate(username, password)
      # end

      # Give more options with the type of response
      authenticate_basic_auth || render_unauthorized
    end

    def authenticate_basic_auth
      authenticate_with_http_basic do |username, password|
        User.authenticate(username, password)
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Basic realm="Episodes"'

      respond_to do |format|
        format.json { render json: 'Bad Credentials', status: 401}
        format.xml { render xml: 'Bad Credentials', status: 401}
      end
    end

    private

    def episode_params
      params.require(:episode).permit(:title, :description)
    end
  end
end