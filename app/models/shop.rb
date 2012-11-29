class Shop < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :rating, :yelp_url, :img_url
  has_many :visits
  validates :name, :uniqueness => { :scope => [:latitude , :longitude] }

  def self.update_or_create_by_name_and_latitude_and_longitude(params)
    name, long, lat = params.delete(:name), params.delete(:latitude), params.delete(:longitude)
    shop = self.find_or_create_by_name_and_latitude_and_longitude name, long, lat
    shop.update_attributes(params)
    shop
  end
end
