module Astrails
  module Auth
    class Mailer < ActionMailer::Base

      def password_reset_instructions(user)
        domain = default_url_options[:host] = GlobalPreference.get(:domain)
        subject       "Password Reset Instructions"
        from          "Password Reset <noreply@#{domain}>"
        recipients    user.email
        sent_on       Time.now
        body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
      end
    end
  end
end
