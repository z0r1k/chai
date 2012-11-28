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

    render :json => { :businesses => @results[:businesses], :region =>  @results[:region] }



    logger.info "------------------"
    logger.info @results
    logger.info "------------------"


  end
end
