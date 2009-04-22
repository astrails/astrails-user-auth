module Astrails
  module Auth
    module Specs
      module PasswordResetsController
        def self.included(base)
          base.class_eval do
            setup :activate_authlogic

            describe "when logged in" do
              stub_current_user
              [:new, :create, :edit, :update].each do |action|
                describe_action(action) do
                  it_should_redirect_to("/") {"/"}
                end
              end
            end

            describe "when logged out" do
              describe_action(:new) do
                it_should_render_template "new"
              end

              describe_action(:create) do
                describe "w/o valid email" do
                  it_should_match(:flash, :error, /no.*found/i)
                  it_should_render_template "new"
                end
                describe "with valid email" do
                  before(:each) do
                    @user = stub_user
                    @user.stub!(:deliver_password_reset_instructions!)
                    User.stub!(:find_by_email).with("some email").and_return(@user)
                    params[:email] = "some email"
                  end

                  it_should_set(:flash, :notice)
                  it_should_redirect_to("/") {"/"}
                  it_should_find :user, :method => :find_by_email, :params => :email
                  it "should call deliver_password_reset_instructions!" do
                    @user.should_receive(:deliver_password_reset_instructions!)
                    eval_request
                  end
                end
              end

              describe "without token" do
                [:edit, :update].each do |action|
                  describe_action(action) do
                    it_should_redirect_to('/') {'/'}
                    it_should_match(:flash, :error, /no.*locate/i)
                  end
                end
              end

              describe "with token" do
                before(:each) do
                  @user = stub_user
                  User.stub!(:find_using_perishable_token).with(@user.perishable_token).and_return(@user)
                  params[:id] = @user.perishable_token
                end
                describe_action(:edit) do
                  it_should_render_template "edit"
                  it_should_find :user, :method => :find_using_perishable_token, :params => :id
                end

                describe_action(:update) do
                  describe "when passwords match" do
                    stubs_for_update(:user)
                    before(:each) do
                      params[:user] = {:password => "qweqwe", :password_confirmation => "qweqwe"}
                    end

                    it_should_find :user, :method => :find_using_perishable_token, :params => :id
                    it_should_update :user, [{"password" => "qweqwe", "password_confirmation" => "qweqwe"}]
                    it_should_redirect_to("account_path") {account_path}
                    it_should_match(:flash, :notice, /updated/i)
                  end

                  describe "when passwords don't match" do
                    stubs_for_update(:user, false)

                    it_should_render_template "edit"
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
