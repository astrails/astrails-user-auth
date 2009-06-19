module Astrails
  module Auth
    module Spec
      module Views
        module Users
          module ShowHtml
            def self.included(base)
              base.class_eval do
                setup :activate_authlogic
                before(:each) do
                  @user = mock_and_assign(User, :stub => {
                    :name => "foo",
                    :email => "foo",
                    :password => "foo"
                  })
                  #@controller.class.send :helper, ResourceController::Helpers::Urls
                  #@controller.class.send :resource_controller
                  # template.stub!(:edit_object_url).and_return(edit_polymorphic_path(@user))
                  # template.stub!(:collection_url).and_return(users_path)

                end

                it "should render" do
                  render "/users/show"
                end

                # it_should_link_to { users_path }
                it "needs tests"

              end
            end
          end
        end
      end
    end
  end
end
