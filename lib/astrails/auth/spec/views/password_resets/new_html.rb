module Astrails
  module Auth
    module Spec
      module Views
        module PasswordResets
          module NewHtml
            def self.included(base)
              base.class_eval do
                it "should render new form" do
                  render "/password_resets/new.html.haml"

                  response.should have_tag("form[action=?][method=post]", password_resets_path) do
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
