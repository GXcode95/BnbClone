class RealEstatesController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show
    @reservation = Reservation.new
  end

  def new; end

  def edit; end

  def create
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
