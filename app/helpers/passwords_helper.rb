module PasswordsHelper
  def password_submit_label
    if logged_in?
      "Change"
    elsif @user.active?
      "Reset"
    else
      "Activate"
    end
  end

  def password_form_title
    if logged_in?
      "Change Password"
    elsif @user.active?
      "Password Reset"
    else
      "Activate Account"
    end
  end

  def password_reset_submit_label
    if @user.active?
      "Send Password Reset instructions"
    else
      "Send Activation instructions"
    end
  end
end