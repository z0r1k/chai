class AddLatitudeLongitudeGmapsToShops < ActiveRecord::Migration
  def change
    add_column :shops, :latitude, :float
    add_column :shops, :longitude, :float
    add_column :shops, :gmaps, :boolean
  end
end
