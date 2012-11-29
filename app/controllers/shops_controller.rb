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
      Shop.update_or_create_by_name_and_latitude_and_longitude shop.except(:distance, :review_count)
    end


    render :json => { :businesses => @results[:businesses], :region =>  @results[:region] }



    logger.info "------------------"
    logger.info @results
    logger.info "------------------"


  end
end
