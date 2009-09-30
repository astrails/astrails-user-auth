module Astrails
  module Auth
    module Spec
      module Views
        module Passwords
          module EditHtml
            def self.included(base)
              base.class_eval do
                before do
                  @user = assigns[:user] = stub_user
                end

                it "should render edit form" do
                  render "/passwords/edit.html.haml"

                  response.should have_tag("form[action=#{password_path(@user.perishable_token)}][method=post]") do
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
