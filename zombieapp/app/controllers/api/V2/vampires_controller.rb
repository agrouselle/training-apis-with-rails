module API
  module V2
    class VampiresController < ::API::V2::BaseController
      def index
        render json: "#{@remote_ip} Vampire Version TWO", status: 200
      end
    end
  end
end

