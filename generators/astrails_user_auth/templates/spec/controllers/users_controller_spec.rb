require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  setup :activate_authlogic

  describe "when not logged in" do
    [:index, :show, :update, :destroy].each do |action|
      describe_action(action) do
        it_should_redirect_to("/login") {login_path}
      end
    end

    describe_action :new do
      stubs_for_new(User)

      it_should_render_template :new
      it_should_initialize_and_assign :user

      # TODO in view test:
      #it "should not render password from params" do
    end

    describe_action :create do

      describe "with empty form" do
        stubs_for_create(User, false)
        it_should_render_template :new
        it_should_initialize_and_assign :user
      end

      describe "with valid form" do
        stubs_for_create(User)
        it_should_initialize_and_save :user
        it_should_set_flash :notice
        it_should_redirect_to("user_path(@user)") {user_path(@user)}

        it "should create admin if no other users" do
          User.should_receive(:count).and_return(0)
          eval_request
          @user.should be_is_admin
        end

        it "should not create admin if there are other users" do
          User.should_receive(:count).and_return(1)
          eval_request
          @user.should_not be_is_admin
        end
      end

    end
  end

  describe "regular user" do
    stub_current_user

    describe_action :index  do
      stubs_for_index(:user)
      it_should_render_template :index
      it "needs more tests"
    end

    describe_action :new do
      it_should_redirect_to("/home") {"/home"}
      it_should_match(:flash, :error, /logged out/i)
    end

    describe_action :create do
      it_should_redirect_to("/home") {"/home"}
      it_should_match(:flash, :error, /logged out/i)
    end

    describe "accessing other profile" do
      with_other_user :param_name => :id

      [:update, :destroy].each do |action|
        describe_action(action) do
          it_should_redirect_to("/") {"/"}
          it_should_match(:flash, :error, /owner/i)
        end
      end
    end

    describe "assessing own profile" do
      with_current_user :param_name => :id

      describe_action(:show) do
        it_should_render_template "show"
        it_should_find :user
        it_should_assign :user
      end

      describe_action(:update) do
        describe "when successfull" do
          stubs_for_update(:user)

          it_should_find :user
          it_should_update :user
          it_should_redirect_to("user_path(@user)") {user_path(@user)}
          it_should_match(:flash, :notice, /success/i)
        end

        describe "when unsuccessfull" do
          stubs_for_update(:user, false)
          it_should_find :user
          it_should_assign :user
          it_should_update :user
          it_should_render_template "show"
          it_should_match(:flash_now, :notice, /fail/i)
        end
      end

      describe_action(:destroy) do
        describe "when successfull" do
          stubs_for_destroy(:user)

          it_should_find :user
          it_should_destroy :user
          it_should_redirect_to("/users") {users_path}
          #it_should_logout
          it "should logout" do
            eval_request
            session["user_credentials"].should be_nil
          end
        end
        describe "when unsuccessfull" do
          stubs_for_destroy(:user, false)

          it_should_match(:flash, :notice, /fail/i)
          it_should_redirect_to("/users") {users_path}
        end
      end

    end

  end

  describe "admin" do
    stub_current_user(:is_admin => true)

    describe_action :index do
      stubs_for_index(:user)
      it_should_render_template "index"
      it_should_paginate_and_assign :users
    end
  end
end
