class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string   :name
      t.string   :latitude
      t.string   :longitude
      t.decimal  :rating
      t.string   :yelp_url
      t.string   :img_url
      t.timestamps
    end
  end
end
