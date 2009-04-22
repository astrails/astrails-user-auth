class User < ActiveRecord::Base
  acts_as_authentic 
  include Astrails::Auth::Model
end
