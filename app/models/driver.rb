class Driver < ApplicationRecord
  validates :name, presence: true
  validates :home_address, presence: true
end
