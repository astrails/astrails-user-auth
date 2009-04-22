class UserSessionController < ResourceController::Singleton
  actions :new, :create, :destroy

  create.wants.html {redirect_to "/"}
  destroy.wants.html {redirect_to login_path}

  private
  def object
    @object ||= current_user_session
  end

end
