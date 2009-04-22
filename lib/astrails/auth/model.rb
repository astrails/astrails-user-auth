module Astrails
  module Auth
    module Model
      def deliver_password_reset_instructions!
        reset_perishable_token!
        ::Astrails::Auth::Mailer.deliver_password_reset_instructions(self)
      end
    end
  end
end

