require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users/index.html.haml" do
  include Astrails::Auth::Spec::Views::Users::IndexHtml
end
