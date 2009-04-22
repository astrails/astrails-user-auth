require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PasswordResetsController do
  include Astrails::Auth::Specs::PasswordResetsRouting
end
