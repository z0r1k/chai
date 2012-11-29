class ShopsController < ApplicationController
  # before_filter :authenticate_user!

  def index
    @shops = Shop.all
  end

  def create
    # sends a search query to Yelp via our YelpHelper module
    @search = YelpHelper.query("#{params[:latitude]},#{params[:longitude]}")
    logger.info "------------------"
    logger.info @search
    logger.info "------------------"

    # gets the results from our YelpHelper module query
    @results = YelpHelper.search("#{params[:latitude]},#{params[:longitude]}")
    logger.info "------------------"
    logger.info @results
    logger.info "------------------"

    @results[:businesses].each  do |shop|
      @shop = Shop.new
      @shop.name = shop[:name]
      @shop.latitude = shop[:latitude]
      @shop.longitude = shop[:longitude]
      @shop.rating = shop[:rating]
      @shop.yelp_url = shop[:yelp_url]
      @shop.img_url = shop[:img_url]
      @shop.save
    end


    render :json => { :businesses => @results[:businesses], :region =>  @results[:region] }



    logger.info "------------------"
    logger.info @results
    logger.info "------------------"


  end
end
