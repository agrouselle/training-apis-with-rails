module API
  module V1
    class VampiresController < ::API::BaseController
      def index
        render json: "#{@remote_ip} Vampire Version ONE", status: 200
      end
    end
  end
end
