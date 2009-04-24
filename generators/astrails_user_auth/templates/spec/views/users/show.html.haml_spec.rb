require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users/show.html.haml" do
  include Astrails::Auth::Spec::Views::Users::ShowHtml
end
