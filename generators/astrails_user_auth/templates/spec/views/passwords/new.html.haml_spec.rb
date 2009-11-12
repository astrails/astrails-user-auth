require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/passwords/new.html.haml" do
  it "should render new form" do
    render "/passwords/new.html.haml"

    response.should have_tag("form[action=?][method=post]", passwords_path) do
    end
  end
end
