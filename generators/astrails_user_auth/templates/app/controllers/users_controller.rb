class UsersController < Astrails::ResourceController
  before_filter :require_admin, :only => :index
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_owner, :except => [:new, :create, :index]

  create do
    before do
      # make the first user admin
      @user.is_admin = true if User.count.zero?
      # TODO: activate here
    end
  end

  destroy do
    after do
      current_user_session.destroy
    end
    failure do
      wants.html { redirect_to collection_url }
      after {flash[:error] = "Failed to delete!"}
    end
  end

  protected

  def object
    @object ||= param ? end_of_association_chain.find(param) : current_user
    @object
  end

  def require_owner
    return false unless require_user
    return true unless object # let it fail
    return true if current_user.try(:is_admin?)
    return true if object == current_user # owner

    flash[:error] = "Only the owner can see this page"
    redirect_to "/"
    return false
  end

end
