# == Schema Information
#
# Table name: real_estates
#
#  id          :bigint           not null, primary key
#  address     :string
#  description :string
#  estate_type :integer          not null
#  price       :integer          not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  city_id     :bigint           not null
#  host_id     :bigint           not null
#
# Indexes
#
#  index_real_estates_on_city_id  (city_id)
#  index_real_estates_on_host_id  (host_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#  fk_rails_...  (host_id => users.id)
#
class RealEstate < ApplicationRecord
  enum estate_types: { house: 0, apartment: 1, guesthouse: 2, hotel: 3 }

  belongs_to :host, class_name: :User
  belongs_to :city

  has_many :reservations
  has_many :guests, through: :reservations
  has_many :days

  validates :address, length: { minimumn: 7, maximum: 50 }
  validates :title, presence: true, length: { minimumn: 10, maximum: 50 }
  validates :estate_type, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 2000 }

  accepts_nested_attributes_for :days, allow_destroy: true

  scope :by_city, ->(city) { where(city: city) }
end
