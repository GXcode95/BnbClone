class UserMailer < ApplicationMailer
  def reservation_created(user_name:, email:, reservation_date:, estate_title:)
    @user_name = user_name
    @reservation_date = reservation_date
    @estate_title = estate_title

    mail(to: email,
         subject: 'Reservation created !')
  end

  def new_reservation(user_name:, email:, estate_title:, estate_id:, reservation_date:)
    @user_name = user_name
    @reservation_date = reservation_date
    @estate_title = estate_title
    @estate_path = "/estate/#{estate_id}"

    mail(to: email,
         subject: 'New reservation !')
  end

  def reservation_accepted(user_name:, email:, estate_title:, reservation_date:)
    @user_name = user_name
    @reservation_date = reservation_date
    @estate_title = estate_title

    mail(to: email,
         subject: 'Reservation accepted !')
  end

  def reservation_canceled(user_name:, email:, estate_title:, reservation_date:)
    @user_name = user_name
    @reservation_date = reservation_date
    @estate_title = estate_title

    mail(to: email,
         subject: 'Reservation canceled !')
  end
end
