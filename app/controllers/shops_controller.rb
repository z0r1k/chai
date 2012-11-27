class ShopsController < ApplicationController
  def index

  end

  def create
    @search = YelpHelper.query("#{params[:latitude]},#{params[:longitude]}")
    logger.info "------------------"
    logger.info @search
    logger.info "------------------"


    @results = YelpHelper.search("#{params[:latitude]},#{params[:longitude]}")
    render :json => {:results => @results}



    logger.info "------------------"
    logger.info @results
    logger.info "------------------"

  end
end
