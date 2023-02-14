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
  
  has_one :host, through: :real_estate  
  
  validates :checkin, presence: true, date: { after_or_equal_to: Date.today }
  validates :checkout, presence: true, date: { after: :checkin,  message: 'must must be at least one day after checkin.' }

  validate :checkin_and_checkout_are_on_free_period

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
end
