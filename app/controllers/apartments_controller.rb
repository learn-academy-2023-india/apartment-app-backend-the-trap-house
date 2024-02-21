class ApartmentsController < ApplicationController
  ApplicationController
    def index
      apartments = Apartment.all
      render json: apartments
    end

    def create
      apartment = Apartment.create(apartment_params)
      if apartment.valid?
        render json: apartment
      else
        render json: apartment.errors, status: 422
      end
    end

    private
    def apartment_params
      params.require(:apartment).permit(:street, :unit, :city, :state, :square_footage, :price, :bedrooms, :bathrooms, :pets, :image, :user_id)
    end
end

