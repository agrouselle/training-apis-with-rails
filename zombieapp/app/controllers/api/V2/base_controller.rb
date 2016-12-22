module API
  module V2
    class BaseController < ::API::BaseController
      abstract!

      before_action :audit_logging_for_v2

      def audit_logging_for_v2
        logger.info("Auditing...")
      end
    end
  end
end