require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/passwords/new.html.haml" do
  include Astrails::Auth::Spec::Views::PasswordResets::NewHtml
end
