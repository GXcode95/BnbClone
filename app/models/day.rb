# == Schema Information
#
# Table name: days
#
#  id             :bigint           not null, primary key
#  date           :date             not null
#  taken          :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  real_estate_id :bigint           not null
#
# Indexes
#
#  index_days_on_real_estate_id  (real_estate_id)
#
# Foreign Keys
#
#  fk_rails_...  (real_estate_id => real_estates.id)
#
class Day < ApplicationRecord
  belongs_to :real_estate
end
