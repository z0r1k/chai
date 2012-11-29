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
      # @shop = Shop.find_by_name_and_latitude_and_longitude(shop[:name],shop[:latitude],shop[:longitude])
      # if @shop
      #   @shop.update_attributes(name: shop[:name],
      #                           latitude: shop[:latitude],
      #                           longitude: shop[:longitude],
      #                           rating: shop[:rating],
      #                           yelp_url: shop[:url],
      #                           img_url: shop[:image_url])

      # else
      #   @shop = Shop.new
      #   @shop.name = shop[:name]
      #   @shop.latitude = shop[:latitude]
      #   @shop.longitude = shop[:longitude]
      #   @shop.rating = shop[:rating]
      #   @shop.yelp_url = shop[:url]
      #   @shop.img_url = shop[:image_url]
      #   logger.info "------------------"
      #   logger.info "shop info:"
      #   logger.info @shop.yelp_url
      #   logger.info @shop.img_url
      #   logger.info "------------------"
      #   @shop.save
      # end
    end


    render :json => { :businesses => @results[:businesses], :region =>  @results[:region] }



    logger.info "------------------"
    logger.info @results
    logger.info "------------------"


  end
end
