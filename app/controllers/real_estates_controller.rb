class RealEstatesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  def index
    @real_estates = @real_estates.includes(:days).where(days: { taken: false  })
    return unless params[:city]

    @real_estates = @real_estates.by_city(City.where('lower(name) like ?', "%#{params[:city].downcase}%")) 
  end

  def show
    @reservation = Reservation.new
  end

  def new; end

  def edit; end

  def create
    @real_estate.host = current_user
    if @real_estate.save
      redirect_to real_estate_url(@real_estate), notice: 'Real estate was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @real_estate.update(real_estate_params)
      redirect_to real_estate_url(@real_estate), notice: 'Real estate was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @real_estate.destroy

    redirect_to real_estates_url, notice: 'Real estate was successfully destroyed.'
  end

  private

  def real_estate_params
    params.require(:real_estate).permit(:title, :description, :address, :estate_type, :price, :host_id, :city_id, days_attributes: [ :id, :taken, :date ])
  end
end
