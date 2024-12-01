class Tip < ApplicationRecord
  validates :bill, :tip_percentage, :number_of_people, presence: true
  validates :bill, numericality: { greater_than: 0 }
  validates :tip_percentage, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :number_of_people, numericality: { only_integer: true, greater_than: 0 }
end
