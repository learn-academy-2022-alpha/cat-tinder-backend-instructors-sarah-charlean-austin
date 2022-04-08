class Cat < ApplicationRecord
  # Validations go here
  validates :name, :age, :enjoys, presence: true
  validates :enjoys, length: { minimum: 10 }
end
