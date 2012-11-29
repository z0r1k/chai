class VisitsController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
    @visits = Visit.all
  end

  def create
    @visit = Visit.new(params[:visit])
    @visit.user = current_user
    logger.info "****************"
    logger.info "visit: #{@visit.user_id}"
    logger.info "params: #{params}"
    logger.info "****************"
    @visit.save

  end

  def new
    @visit = Visit.new
  end

  def edit

  end

  def show
    @visit = Visit.find(params[:id])
  end

  def update

  end

  def destroy

  end

end
