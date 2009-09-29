class UserSessionController < ResourceController::Singleton
  unloadable
  actions :new, :create, :destroy
  layout "guest"
  before_filter :require_user, :only => :destroy

  create do
    flash nil
    wants.html {redirect_back_or_default home_path}
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
