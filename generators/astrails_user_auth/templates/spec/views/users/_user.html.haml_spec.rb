require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users/_user.html.haml" do
  before(:each) do
    @user = mock_and_assign(User, :stub => {
      :name => "foo",
      :email => "foo",
      :password => "foo"
    })
    template.stub!(:user).and_return(@user)
  end

  it_should_link_to_show :user
  it_should_link_to_delete :user
end
