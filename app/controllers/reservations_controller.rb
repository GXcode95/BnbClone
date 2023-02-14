class ReservationsController < ApplicationController
  load_and_authorize_resource except: [:index]

  def index; end

  def show; end

  def new; end
  
  def edit; end

  def create
    @reservation.guest = current_user
    if @reservation.save
      redirect_to reservation_url(@reservation), notice: 'Reservation was successfully created.'
    else
      @real_estate = @reservation.real_estate
      render 'real_estates/show', status: :unprocessable_entity
    end
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to reservation_url(@reservation), notice: 'Reservation was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy

    redirect_to reservations_url, notice: 'Reservation was successfully destroyed.'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:checkin, :checkout, :validated, :real_estate_id, :guest_id)
  end
end
