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
  end
end

