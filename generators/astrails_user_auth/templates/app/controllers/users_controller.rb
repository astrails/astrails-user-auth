class UsersController < InheritedResources::Base
  before_filter :require_admin, :only => [:index, :destroy]
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_owner, :except => [:new, :create, :index]

  def create
    user = build_resource
    user.is_admin = true if User.count.zero?
    # TODO: activate here
    create! {home_path(@user)}
  end

  def destroy
    destroy!
    current_user_session.destroy
  end

  protected

  def require_owner
    return false unless require_user
    return true unless resource # let it fail
    return true if current_user.try(:is_admin?)
    return true if object == current_user # owner

    flash[:error] = "Only the owner can see this page"
    redirect_to "/"
    return false
  end

  def collection
    @users ||= end_of_association_chain.paginate(params[:page]).all
  end

  def resource
    @user ||= params[:id] ? User.find(params[:id]) : current_user
  end

  def build_resource
    params[:user].try(:trust, :name)
    super
  end
end
