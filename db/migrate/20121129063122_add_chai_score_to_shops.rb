class AddChaiScoreToShops < ActiveRecord::Migration
  def up
    add_column :shops, :chai_score, :decimal

    Shop.all.each do |shop|
      shop.calculate_and_save_chai_score
    end

  end



  def down
    remove_column :shops, :chai_score
  end


end
