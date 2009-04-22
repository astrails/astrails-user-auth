module Astrails
  module Auth
    class Mailer < ActionMailer::Base
      default_url_options[:host] = "authlogic_example.binarylogic.com"

      def password_reset_instructions(user)
        subject       "Password Reset Instructions"
        # FIXME: get this from settings file
        from          "Password Reset <noreply@astrails.com>"
        recipients    user.email
        sent_on       Time.now
        body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
      end
    end
  end
end
