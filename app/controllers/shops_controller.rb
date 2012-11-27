class ShopsController < ApplicationController
  def index
    @json = Shop.all.to_gmaps4rails
  end
end
