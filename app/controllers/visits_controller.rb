class VisitsController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
    @visits = Visit.all
  end

  def create
    @visit = Visit.new(params[:visit])
    @visit.user = current_user
    @visit.save
    redirect_to :root
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


# If we need the logger again, it's right here - all cozy
    # logger.info "****************"
    # logger.info "params: #{params}"
    # logger.info "****************"