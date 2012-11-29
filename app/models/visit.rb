class Visit < ActiveRecord::Base
  attr_accessible :user_id, :shop_id, :wifi, :power, :atmosphere
  belongs_to :user
  belongs_to :shop

end