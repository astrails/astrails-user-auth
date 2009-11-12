require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/passwords/edit.html.haml" do
  before do
    @user = assigns[:user] = stub_user
  end

  it "should render edit form" do
    render "/passwords/edit.html.haml"

    response.should have_tag("form[action=#{password_path(@user.perishable_token)}][method=post]") do
    end
  end
end
