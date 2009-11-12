require File.dirname(__FILE__) + '/../../spec_helper'

describe "/user_session/new.html.haml" do
  setup :activate_authlogic

  before do
    @user_session = mock_and_assign(::UserSession)
  end

  it "should render new form" do
    do_render

    response.should have_tag("form[action=?][method=post]", user_session_path) do
    end
  end
end

