module API
  module V2
    class ZombiesController < ::API::V2::BaseController
      def index
        render json: "#{@remote_ip} Version TWO", status: 200
      end
    end
  end
end
