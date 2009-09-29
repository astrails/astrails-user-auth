class PasswordController < InheritedResources::Base
  unloadable

  actions :update, :edit

  before_filter :require_no_user, :except => [:edit, :update]
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  layout "guest"

  # new! + new.html.haml

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user
      @user.deliver_password_reset_instructions!
      if @user.activated_at
        # user is already active
        flash[:notice] = "Instructions to reset your password have been emailed to you. Please check your email."
      else
        flash[:notice] = "Instructions to activate your account have been emailed to you. Please check your email."
      end
      redirect_to root_url
    else
      flash[:error] = "No user was found with that email address"
      render :action => :new
    end
  end

  #edit! + edit.html.haml

  def update
    update! {profile_path}
  end

  private

  def resource
    @user ||= params[:id] ? User.find_using_perishable_token(params[:id]) : current_user
  end

  def load_user_using_perishable_token
    unless object
      flash[:error] = <<-END
        We're sorry, but we could not locate your account.
        If you are having issues try copying and pasting the URL
        from your email into your browser or restarting the
        reset password process.
      END
      redirect_to root_url
    end
  end

end
