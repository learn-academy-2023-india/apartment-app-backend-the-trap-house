require 'rails_helper'

RSpec.describe "Apartments", type: :request do
  let(:user) { User.create(
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
      )
    }
  
    describe "GET /index" do
      it 'gets a list of apartments' do
        apartment = user.apartments.create(
          street: '4 Privet Drive',
          unit: '2A',
          city: 'Little Whinging',
          state: 'Surrey',
          square_footage: 2000,
          price: '2000',
          bedrooms: 3,
          bathrooms: 2,
          pets: 'yes',
          image: 'https://c8.alamy.com/comp/B0RJGE/small-bungalow-home-with-pathway-in-addlestone-surrey-uk-B0RJGE.jpg'
        )
        get '/apartments'
  
        apartment = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(apartment.first['street']).to eq('4 Privet Drive')
        expect(apartment.first['unit']).to eq('2A')
        expect(apartment.first['city']).to eq('Little Whinging')
        expect(apartment.first['state']).to eq('Surrey')
        expect(apartment.first['square_footage']).to eq('2000')
        expect(apartment.first['price']).to eq('2000')
        expect(apartment.first['bedrooms']).to eq('3')
        expect(apartment.first['bathrooms']).to eq('2')
        expect(apartment.first['pets']).to eq('yes')
        expect(apartment.first['image']).to eq('https://c8.alamy.com/comp/B0RJGE/small-bungalow-home-with-pathway-in-addlestone-surrey-uk-B0RJGE.jpg')
        expect(response).to have_http_status('200')
      end
    end

    it 'creates a new apartment' do
      apartment_params = {
        apartment: {
          street: 'Evergreen Terrace',
          unit: '742',
          city: 'Springfield',
          state: 'Oregon',
          square_footage: 3500,
          price: '1875',
          bedroom: 4,
          bathrooms: 3.5,
          pets: 'yes',
          image: 'https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2022%2F11%2Fthe-simpsons-house-reimagined-styles-1.jpg?cbr=1&q=90',
          user_id: user.id
        }
      }
      post '/apartments', params: apartment_params

      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      apartment = Apartment.first 
      expect(apartment['street']).to eq('Evergreen Terrace')
      expect(apartment['unit']).to eq('742')
      expect(apartment['city']).to eq('Springfield')
      expect(apartment['state']).to eq('Oregon')
      expect(apartment['square_footage']).to eq(3500)
      expect(apartment['price']).to eq('1875')
      expect(apartment['bedrooms']).to eq(4)
      expect(apartment['bathrooms']).to eq(3.5)
      expect(apartment['pets']).to eq('yes')
      expect(apartment['image']).to eq('https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2022%2F11%2Fthe-simpsons-house-reimagined-styles-1.jpg?cbr=1&q=90')
      expect(apartment['user_id']).to eq(user.id)
    end

    it "doesn't create an apartment without a street" do
      apartment_params = {
        apartment: {
          unit: '742',
          city: 'Springfield',
          state: 'Oregon',
          square_footage: 3500,
          price: '1875',
          bedroom: 4,
          bathrooms: 3.5,
          pets: 'yes',
          image: 'https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2022%2F11%2Fthe-simpsons-house-reimagined-styles-1.jpg?cbr=1&q=90',
          user_id: user.id
        }
      }
      post '/apartments', params: apartment_params

      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['street']).to include "can't be blank"
    end

    it "doesnt create an apartment without a unit" do
      apartment_params = {
        apartment: {
          street: 'Evergreen Terrace',
          city: 'Springfield',
          state: 'Oregon',
          square_footage: 3500,
          price: '1875',
          bedroom: 4,
          bathrooms: 3.5,
          pets: 'yes',
          image: 'https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2022%2F11%2Fthe-simpsons-house-reimagined-styles-1.jpg?cbr=1&q=90',
          user_id: user.id
        }
      }
      post '/apartments', params: apartment_params

      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['unit']).to include "can't be blank"
    end

    it "doesnt create an apartment without a city" do
      apartment_params = {
        apartment: {
          unit: '742'
          street: 'Evergreen Terrace',
          state: 'Oregon',
          square_footage: 3500,
          price: '1875',
          bedroom: 4,
          bathrooms: 3.5,
          pets: 'yes',
          image: 'https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2022%2F11%2Fthe-simpsons-house-reimagined-styles-1.jpg?cbr=1&q=90',
          user_id: user.id
        }
      }
      post '/apartments', params: apartment_params

      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['city']).to include "can't be blank"
    end

    it "doesnt create an apartment without a state" do
      apartment_params = {
        apartment: {
          unit: '742'
          street: 'Evergreen Terrace',
          city: 'Springfield',
          square_footage: 3500,
          price: '1875',
          bedroom: 4,
          bathrooms: 3.5,
          pets: 'yes',
          image: 'https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2022%2F11%2Fthe-simpsons-house-reimagined-styles-1.jpg?cbr=1&q=90',
          user_id: user.id
        }
      }
      post '/apartments', params: apartment_params

      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['state']).to include "can't be blank"
    end

    it "doesnt create an apartment without a square footage" do
      apartment_params = {
        apartment: {
          unit: '742'
          street: 'Evergreen Terrace',
          city: 'Springfield',
          state: 'Oregon',
          price: '1875',
          bedroom: 4,
          bathrooms: 3.5,
          pets: 'yes',
          image: 'https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2022%2F11%2Fthe-simpsons-house-reimagined-styles-1.jpg?cbr=1&q=90',
          user_id: user.id
        }
      }
      post '/apartments', params: apartment_params

      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['square_footage']).to include "can't be blank"
    end

    it "doesnt create an apartment without a price" do
      apartment_params = {
        apartment: {
          unit: '742'
          street: 'Evergreen Terrace',
          city: 'Springfield',
          state: 'Oregon',
          square_footage: 3500,
          bedroom: 4,
          bathrooms: 3.5,
          pets: 'yes',
          image: 'https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2022%2F11%2Fthe-simpsons-house-reimagined-styles-1.jpg?cbr=1&q=90',
          user_id: user.id
        }
      }
      post '/apartments', params: apartment_params

      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['price']).to include "can't be blank"
    end

    it "doesnt create an apartment without a bedrooms" do
      apartment_params = {
        apartment: {
          unit: '742'
          street: 'Evergreen Terrace',
          city: 'Springfield',
          state: 'Oregon',
          square_footage: 3500,
          price: '1875',
          bathrooms: 3.5,
          pets: 'yes',
          image: 'https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2022%2F11%2Fthe-simpsons-house-reimagined-styles-1.jpg?cbr=1&q=90',
          user_id: user.id
        }
      }
      post '/apartments', params: apartment_params

      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['bedrooms']).to include "can't be blank"
    end

    it "doesnt create an apartment without a bathrooms" do
      apartment_params = {
        apartment: {
          unit: '742'
          street: 'Evergreen Terrace',
          city: 'Springfield',
          state: 'Oregon',
          square_footage: 3500,
          price: '1875',
          bedroom: 4,
          pets: 'yes',
          image: 'https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2022%2F11%2Fthe-simpsons-house-reimagined-styles-1.jpg?cbr=1&q=90',
          user_id: user.id
        }
      }
      post '/apartments', params: apartment_params

      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['bathrooms']).to include "can't be blank"
    end

    it "doesnt create an apartment without a pet" do
      apartment_params = {
        apartment: {
          unit: '742'
          street: 'Evergreen Terrace',
          city: 'Springfield',
          state: 'Oregon',
          square_footage: 3500,
          price: '1875',
          bedroom: 4,
          bathrooms: 3.5,
          image: 'https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2022%2F11%2Fthe-simpsons-house-reimagined-styles-1.jpg?cbr=1&q=90',
          user_id: user.id
        }
      }
      post '/apartments', params: apartment_params

      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['pet']).to include "can't be blank"
    end

    it "doesnt create an apartment without an image" do
      apartment_params = {
        apartment: {
          unit: '742'
          street: 'Evergreen Terrace',
          city: 'Springfield',
          state: 'Oregon',
          square_footage: 3500,
          price: '1875',
          bedroom: 4,
          bathrooms: 3.5,
          pets: 'yes',
          user_id: user.id
        }
      }
      post '/apartments', params: apartment_params

      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['image']).to include "can't be blank"
    end

    it "doesnt create an apartment without a user id" do
      apartment_params = {
        apartment: {
          unit: '742'
          street: 'Evergreen Terrace',
          city: 'Springfield',
          state: 'Oregon',
          square_footage: 3500,
          price: '1875',
          bedroom: 4,
          bathrooms: 3.5,
          pets: 'yes',
          image: 'https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2022%2F11%2Fthe-simpsons-house-reimagined-styles-1.jpg?cbr=1&q=90',
        }
      }
      post '/apartments', params: apartment_params

      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['user_id']).to include "can't be blank"
    end
  end
end

