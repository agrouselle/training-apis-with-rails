module API
  module V1
    class ZombiesController < ::API::BaseController
      def index
        render json: "#{@remote_ip} Version ONE", status: 200
      end
    end
  end
end
