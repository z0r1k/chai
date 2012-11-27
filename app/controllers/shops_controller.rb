class ShopsController < ApplicationController
  def index

  end

  def create
    @search = YelpHelper.query("#{params[:latitude]},#{params[:longitude]}")
    logger.info "------------------"
    logger.info @search
    logger.info "------------------"


    @results = YelpHelper.search("#{params[:latitude]},#{params[:longitude]}")
    logger.info "------------------"
    logger.info @results
    logger.info "------------------"

    render :json => { :businesses => @results } #:businesses], :region =>  @results[:region] }



    logger.info "------------------"
    logger.info @results
    logger.info "------------------"

  end
end
