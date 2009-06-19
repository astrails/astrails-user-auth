module Astrails
  module Auth
    module Spec
      module Views
        module Users
          module IndexHtml
            def self.included(base)
              base.class_eval do

                setup :activate_authlogic
                before(:each) do
                  @users = assigns[:users] = (Array.new(3) {stub_user}).paginate

                  template.stub!(:new_object_url).and_return(new_polymorphic_path(User))
                end

                it "should render" do
                  render '/users/index'
                end

                it "should have more tests"
              end
            end
          end
        end
      end
    end
  end
end
