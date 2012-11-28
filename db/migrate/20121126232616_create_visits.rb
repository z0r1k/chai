class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references  :user
      t.references  :shop
      t.integer     :wifi
      t.integer     :power
      t.integer     :atmosphere
      t.timestamps
    end
  end
end
