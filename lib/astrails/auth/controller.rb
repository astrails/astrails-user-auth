module Astrails
  module Auth
    module Controller
      def self.included(base)
        base.class_eval do
          helper_method :current_user
          helper_method :current_user_session
        end
      end
      def current_user_session
        defined?(@current_user_session) ? @current_user_session : @current_user_session = UserSession.find
      end

      def current_user
        defined?(@current_user) ? @current_user : @current_user = current_user_session.try(:user)
      end

      def require_user
        return true if current_user

        store_location
        flash[:error] = "You must be logged in to access this page"
        redirect_to login_path
        return false
      end

      def require_no_user
        return true unless current_user

        store_location
        flash[:error] = "You must be logged out to access this page"
        redirect_to "/"
        return false
      end

      def require_admin
        return false if false == require_user
        return true if current_user.is_admin?

        flash[:error] = "You must be an admin to access this page"
        redirect_to "/"
        return false
      end

      def store_location
        session[:return_to] = request.request_uri if request.get? # we can only return to GET locations
      end

      def redirect_back_or_default(default)
        redirect_to(session[:return_to] || default)
        session[:return_to] = nil
      end
    end
  end
end
