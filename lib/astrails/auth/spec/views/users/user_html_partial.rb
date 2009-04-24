module Astrails
  module Auth
    module Spec
      module Views
        module Users
          module UserHtmlPartial
            def self.included(base)
              base.class_eval do
                before(:each) do
                  @user = mock_and_assign(User, :stub => {
                    :name => "foo",
                    :email => "foo",
                    :password => "foo"
                  })
                  template.stub!(:user).and_return(@user)
                end

                it_should_link_to_show :user
                it_should_link_to_edit :user
                it_should_link_to_delete :user
              end
            end
          end
        end
      end
    end
  end
end

