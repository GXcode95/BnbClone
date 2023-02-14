# == Schema Information
#
# Table name: cities
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class City < ApplicationRecord
  has_many :real_estates
  

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
end
