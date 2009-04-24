require File.dirname(__FILE__) + '/../../spec_helper'

describe "/user_session/new.html.haml" do
  include Astrails::Auth::Spec::Views::UserSession::NewHtml
end

