class ReservationsController < ApplicationController
  load_and_authorize_resource

  def index
    @reservations = params[:host] ? Reservation.by_host(current_user) : Reservation.by_guest(current_user)
  end

  def show; end

  def new; end

  def edit
    @real_estate = @reservation.real_estate
  end

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
    @real_estate = @reservation.real_estate
    if @reservation.update(reservation_params)
      redirect_to reservation_url(@reservation), notice: 'Reservation was successfully updated.'
    else
      render :show, status: :unprocessable_entity
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
