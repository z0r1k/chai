require 'spec_helper'
require 'simplecov'
SimpleCov.start 'rails'

describe Shop do
  describe "Shop object is created correctly" do
    before(:all) do
      Shop.destroy_all
      @test_shop = FactoryGirl.create(:shop1)
    end

    it "validates uniqueness" do
      shop = FactoryGirl.build(:shop1)
      shop.should_not be_valid
    end

    it "should have a latitude" do
      @test_shop.latitude.should == 37.7896539
    end

    it "should have a longitude" do
      @test_shop.longitude.should == -122.4019653
    end

    it "should have a rating" do
      @test_shop.rating.should == 4.5
    end

    it "should have an address" do
      @test_shop.address.should == "717 California Ave, San Francisco, CA"
    end

    it "should have a yelp_url" do
      @test_shop.yelp_url.should == "http://www.devbootcamp.com"
    end

    it "should have an image" do
      @test_shop.img_url.should == "http://devbootcamp.com/imgs/teaching-large-sherif.png"
    end

    it "should have an id" do
      @test_shop.id.should be_kind_of(Integer)
    end
  end

  describe "Chai Score is calculated correctly" do
    before (:all) do
      Visit.destroy_all
      Shop.destroy_all
      @test_shop = FactoryGirl.create(:shop1)
    end

    it "#calculate_chai_score: should calculate the chai score correctly" do
      visit1 = FactoryGirl.create(:visit1)
      visit2 = FactoryGirl.create(:visit2)
      @test_shop.calculate_chai_score.should be_within(0.1).of(4.83)
    end

    it "#calculate_and_save_chai_score: should calculate and save score correctly" do
      @test_shop.chai_score.should == nil
      @test_shop.calculate_and_save_chai_score
      @test_shop.chai_score.should == 0
    end
  end

  describe "Shop is updated correctly if name, lat, long are the same" do
    before (:all) do
      Shop.destroy_all
      @shop1 = FactoryGirl.create(:shop1)
    end

    it "#update_or_create_by_name_and_latitude_and_longitude: updates correctly" do
      @shop1.name.should == "Boot Coffee"
      params = {:name => }
      @shop1.update_or_create_by_name_and_latitude_and_longitude()
    end

  end

end

