module API
  class BaseController < ApplicationController
    abstract!

    before_action :set_remote_ip

    def set_remote_ip
      @remote_ip = request.headers['REMOTE_ADDR']
    end
  end
end