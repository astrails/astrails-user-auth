class User < ActiveRecord::Base
  acts_as_authentic do
    c.perishable_token_valid_for = 2.weeks
  end
  include Astrails::Auth::Model
end
