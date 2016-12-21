module API
  class EpisodesController < ApplicationController
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

    private

    def episode_params
      params.require(:episode).permit(:title, :description)
    end
  end
end