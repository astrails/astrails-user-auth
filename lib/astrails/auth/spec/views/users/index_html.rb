module Astrails
  module Auth
    module Spec
      module Views
        module Users
          module IndexHtml
            def self.included(base)
              base.class_eval do
                before(:each) do
                  @users = mock_and_assign_collection(User)

                  template.stub!(:new_object_url).and_return(new_polymorphic_path(User))
                end

                it "should render :partial => @users" do
                  template.should_receive(:render).with(:partial => @users)
                  do_render
                end

                it_should_link_to_new :user
              end
            end
          end
        end
      end
    end
  end
end
