module Astrails
  module Auth
    module Model
      def deliver_password_reset_instructions!
        reset_perishable_token!
        ::Astrails::Auth::Mailer.deliver_password_reset_instructions(self)
      end

      def active?
        !!activated_at
      end

      def acvivate!
        self.activated_at = Time.now
        save!
      end

      def deliver_password_reset_instructions!
        reset_perishable_token!
        ::Astrails::Auth::Mailer.deliver_password_reset_instructions(self)
      end

      def deliver_password_reset_confirmation!
        reset_perishable_token!
        ::Astrails::Auth::Mailer.deliver_password_reset_confirmation(self)
      end

      def deliver_activation_instructions!
        reset_perishable_token!
        ::Astrails::Auth::Mailer.deliver_activation_instructions(self)
      end

      def deliver_activation_confirmation!
        reset_perishable_token!
        ::Astrails::Auth::Mailer.deliver_activation_confirmation(self)
      end
    end
  end
end

