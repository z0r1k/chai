class Visit < ActiveRecord::Base
  attr_accessible :user_id, :shop_id, :wifi, :power, :atmosphere
  belongs_to :user
  belongs_to :shop
  after_create :calculate_shop_chai_score

  def calculate_shop_chai_score
    shop.calculate_and_save_chai_score
  end


end