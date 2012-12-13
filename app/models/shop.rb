class Shop < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :rating, :yelp_url,
   :img_url, :address, :city, :state_code, :postal_code, :country_code, :phone
  has_many :visits
  validates :name, :uniqueness => { :scope => [:latitude , :longitude] }
  default_scope order("chai_score DESC")

  def calculate_chai_score
      visits.average("wifi+power+atmosphere").to_f / 3
  end

# checks for the shops chai rating and if it's nil changes it to zero
  def calculate_and_save_chai_score
    # check if it's even possible for coffeeshop to have nil?
    # could become just "update chai_score"
    score = calculate_chai_score
    score.nil? ? (self.chai_score = 0) : (self.chai_score = score)
    self.save
  end


  def self.update_or_create_by_name_and_latitude_and_longitude(params)
    name, long, lat = params.delete(:name), params.delete(:latitude), params.delete(:longitude)
    shop = self.find_or_create_by_name_and_latitude_and_longitude(name, long, lat)
    shop.update_attributes(params)
    shop
  end

  def self.fetch_by_location(latitude, longitude)
    radius = 1 #kilometers
    shops = find_by_location( { latitude: latitude, longitude: longitude }, radius)
    shops = find_yelp_shops( latitude, longitude, radius ) unless shops.length > 5
    # find records by lat & long
    # search yelp if there are less than 5 results
    shops
  end

  def self.find_by_location(location, radius)
    #location = { latitude: params[:latitude], longitude: params[:longitude] }
    box = GeoHelper.bounding_box(location, radius)
    shops = self.where("latitude <= ? AND latitude >= ? AND longitude <= ? AND longitude >= ?",
               box[:north_latitude], box[:south_latitude], box[:east_longitude], box[:west_longitude])
    shops
  end

  def self.find_yelp_shops(latitude, longitude, radius)
    results = YelpHelper.find(latitude, longitude)
    results[:businesses].each  do |shop|
      self.update_or_create_by_name_and_latitude_and_longitude(shop.except(:distance, :review_count))
    end
    shops = find_by_location( { latitude: latitude, longitude: longitude }, radius )
    shops
  end

end

   