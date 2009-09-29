class UserSessionController < InheritedResources::Base
  unloadable
  actions :new, :create, :destroy
  before_filter :require_user, :only => :destroy
  defaults :singleton => true

  create do
    create! do |wants|
      wants.html {redirect_back_or_default home_path}
    end
  end

  destroy do
    destroy! do |watnts|
      wants.html {redirect_to login_path}
    end
  end

  private
  def resource
    @object ||= current_user_session
  end

end
