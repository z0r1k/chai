
class Shop < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :rating, :yelp_url, :img_url
  has_many :visits
end
