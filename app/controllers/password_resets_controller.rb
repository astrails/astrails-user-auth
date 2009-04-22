class PasswordResetsController < ResourceController::Base

  actions :update, :edit

  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]

  # new.html.haml

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = "Instructions to reset your password have been emailed to you. Please check your email."
      redirect_to root_url
    else
      flash[:error] = "No user was found with that email address"
      render :action => :new
    end
  end

  # edit.html.haml

  update do
    wants.html {redirect_to account_path}
    flash "Password successfully updated"
  end

  private

  def object_name; "user"; end

  def object
    @object ||= User.find_using_perishable_token(params[:id])
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
