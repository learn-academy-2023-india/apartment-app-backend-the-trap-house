class Apartment < ApplicationRecord
  belongs_to :user
  validates :street,  :state, :city, :pets, :unit, :square_footage, :price, :bedrooms, :bathrooms, :user_id, presence: true
end