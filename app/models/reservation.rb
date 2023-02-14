# == Schema Information
#
# Table name: reservations
#
#  id             :bigint           not null, primary key
#  checkin        :date             not null
#  checkout       :date             not null
#  validated      :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  guest_id       :bigint           not null
#  real_estate_id :bigint           not null
#
# Indexes
#
#  index_reservations_on_guest_id        (guest_id)
#  index_reservations_on_real_estate_id  (real_estate_id)
#
# Foreign Keys
#
#  fk_rails_...  (guest_id => users.id)
#  fk_rails_...  (real_estate_id => real_estates.id)
#
class Reservation < ApplicationRecord
  belongs_to :real_estate
  belongs_to :guest, class_name: :User

  has_one :host, through: :real_estate•

  validates :checkin, presence: true, date: { after_or_equal_to: Date.today }
  validates :checkout, presence: true, date: { after: :checkin,  message: 'must must be at least one day after checkin.' }

  validate :checkin_and_checkout_are_on_free_period

  after_create :send_reservation_creation_mails
  after_update :send_reservation_accepted_mail, if: -> { saved_change_to_validated? }
  after_destroy :send_reservation_canceled_mail

  private

  def checkin_and_checkout_are_on_free_period
    return unless real_estate

    duration = checkout.mjd - checkin.mjd
    period_days = []
    duration.times { |i| period_days << checkin + i.day }
    period_days = real_estate.days.where(date: period_days)
    return unless period_days.size != duration || (period_days.any? && period_days.where(taken: true).any?)

    errors.add(:checkout, 'some days of the selected period aren\'t available')
    errors.add(:checkin, 'some days of the selected period aren\'t available')
  end

  def send_reservation_created_mail
    UserMailer.reservation_created(
      user_name: guest.name,
      email: guest.email,
      reservation_date: checkin,
      estate_title: real_estate.title
    ).deliver_now

    UserMailer.new_reservation(
      user_name: real_estate.host.name,
      email: real_estate.host.email,
      reservation_date: checkin,
      estate_title: real_estate.title,
      estate_id: real_estate.id
    ).deliver_now
  end

  def send_reservation_accepted_mail
    return unless validated

    UserMailer.reservation_accepted(
      user_name: guest.name,
      email: guest.email,
      reservation_date: checkin,
      estate_title: real_estate.title
    ).deliver_now
  end

  def send_reservation_canceled_mail
    UserMailer.reservation_accepted(
      user_name: real_estate.host.name,
      email: real_estate.host.email,
      reservation_date: checkin,
      estate_title: real_estate.title
    ).deliver_now
  end
end
