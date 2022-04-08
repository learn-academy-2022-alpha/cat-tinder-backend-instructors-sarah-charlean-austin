class Cat < ApplicationRecord
  # Validations go here
  validates :name, :age, :enjoys, :image, presence: true
  validates :enjoys, length: { minimum: 10 }
  validates :image, uniqueness: true
end
