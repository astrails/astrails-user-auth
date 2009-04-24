require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  include Astrails::Auth::Spec::Controllers::UsersRouting
end
