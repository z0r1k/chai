class Shop < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :rating, :yelp_url, :img_url
  has_many :visits
  validates :name, :uniqueness => { :scope => [:latitude , :longitude] }

  def calculate_chai_score
      visits.average("wifi+power+atmosphere").to_f / 3
  end

  def calculate_and_save_chai_score
    score = calculate_chai_score
    if score.nil?
      self.chai_score = 0
    else
      self.chai_score = score
    end
    self.save
  end

  def self.update_or_create_by_name_and_latitude_and_longitude(params)
    name, long, lat = params.delete(:name), params.delete(:latitude), params.delete(:longitude)
    shop = self.find_or_create_by_name_and_latitude_and_longitude(name, long, lat)
    shop.update_attributes(params)
    shop
  end
end
