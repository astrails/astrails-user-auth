class UserSessionController < ResourceController::Singleton
  unloadable
  actions :new, :create, :destroy
  layout "guest"

  create do
    flash nil
    wants.html {redirect_to home_path}
  end
  destroy do
    flash nil
    wants.html {redirect_to login_path}
  end

  private
  def object
    @object ||= current_user_session
  end

end
