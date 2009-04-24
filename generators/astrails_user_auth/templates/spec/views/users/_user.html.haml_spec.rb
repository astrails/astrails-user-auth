require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users/_user.html.haml" do
  include Astrails::Auth::Spec::Views::Users::UserHtmlPartial
end
