module Astrails
  module Auth
    module Spec
      module Controllers
        module UserSessionController
          def self.included(base)
            base.class_eval do
              setup :activate_authlogic

              describe_action :new do
                it_should_render_template "new"
                it_should_assign :user_session
              end
            end
          end
        end
      end
    end
  end
end
