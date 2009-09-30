require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/passwords/edit.html.haml" do
  include Astrails::Auth::Spec::Views::PasswordResets::EditHtml
end
