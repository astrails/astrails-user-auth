module Astrails
  module Auth
    module Spec
      module Views
        module UserSession
          module NewHtml
            def self.included(base)
              base.class_eval do
                setup :activate_authlogic

                before do
                  @user_session = mock_and_assign(::UserSession)
                end

                it "should render new form" do
                  do_render

                  response.should have_tag("form[action=?][method=post]", user_session_path) do
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

