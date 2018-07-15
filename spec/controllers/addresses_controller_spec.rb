require 'rails_helper'

RSpec.describe AddressesController, :type => :controller do
  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) {
        {
          street_address: '1600 Pennsylvania Avenue NW',
          city: 'Washington',
          state: 'DC',
          zip_code: '20500'
        }
      }
      before do
        post 'create', params: valid_params
      end
      it 'creates a new address model with the house number saved' do
        expect(assigns(:address).house_number).to eq '1600'
      end

      it 'creates a new address model with the street name saved' do
        expect(assigns(:address).street_name).to eq 'Pennsylvania'
      end

      it 'creates a new address model with the street name saved' do
        expect(assigns(:address).street_type).to eq 'Avenue'
      end

      it 'creates a new address model with the street post direction saved' do
        expect(assigns(:address).street_postdirection).to eq 'NW'
      end

      it 'creates a new address model with the city saved' do
        expect(assigns(:address).city).to eq 'Washington'
      end

      it 'creates a new address model with the state saved' do
        expect(assigns(:address).state).to eq 'DC'
      end

      it 'creates a new address model with the zip_5 saved' do
        expect(assigns(:address).zip_5).to eq '20500'
      end
    end

    context 'with invalid params' do
      let(:invalid_params) {
        {
          street_address: '1600 Pennsylvania Avenue NW',
          city: 'Washington',
          state: 'D7',
          zip_code: '20500'
        }
      }
      before do
        post 'create', params: invalid_params
      end
      it 'does not save a new address' do
        expect(assigns(:address).save).to be false
      end
    end
    
    context 'with unit' do
      let(:valid_params) {
        {
          street_address: '14200 Polk St Unit 33',
          city: 'Los Angeles',
          state: 'CA',
          zip_code: '91342'
        }
      }
      before do
        post 'create', params: valid_params
      end
      it 'creates a new address model with the house number saved' do
        expect(assigns(:address).unit_type).to eq 'Unit'
      end

      it 'creates a new address model with the street name saved' do
        expect(assigns(:address).unit_number).to eq '33'
      end
    end
  end
end
