module Astrails
  module Auth
    module Spec
      module Views
        module Users
          module ShowHtml
            def self.included(base)
              base.class_eval do
                before(:each) do
                  @user = mock_and_assign(User, :stub => {
                    :name => "foo",
                    :email => "foo",
                    :password => "foo"
                  })
                  #@controller.class.send :helper, ResourceController::Helpers::Urls
                  #@controller.class.send :resource_controller
                  template.stub!(:edit_object_url).and_return(edit_polymorphic_path(@user))
                  template.stub!(:collection_url).and_return(users_path)

                end

                # Add your specs here, please! But remember not to make them brittle
                # by specing specific HTML elements and classes.

                it_should_link_to_edit :user
                it_should_link_to { users_path }
              end
            end
          end
        end
      end
    end
  end
end
