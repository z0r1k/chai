class ShopsController < ApplicationController
  # before_filter :authenticate_user!

  def index
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
      @shop.name = shop[0]
      @shop.latitude = shop[6]
      @shop.longitude = shop[7]
      @shop.rating = shop[2]
      @shop.yelp_url = shop[5]
      @shop.img_url = shop[4]
      @shop.save
    end


    render :json => { :businesses => @results[:businesses], :region =>  @results[:region] }



    logger.info "------------------"
    logger.info @results
    logger.info "------------------"


  end
end
