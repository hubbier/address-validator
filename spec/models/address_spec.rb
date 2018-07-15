require 'rails_helper'

RSpec.describe Address, :type => :model do
  describe '#new' do
    context 'Given a valid address' do
      it 'can create a new address' do
        expect(Address.new(
                          house_number: 1600,
                          street_name: 'Pennsylvania',
                          street_type: 'Avenue',
                          street_postdirection: 'NW',
                          city: 'Washington',
                          state: 'DC',
                          zip_5: 20500
                        )).to be_valid
      end
    end

    context 'Given bad address values' do
      it 'cannot create a new address' do
        expect(Address.new(
                          house_number: 1600,
                          street_name: 'Pennsylvania',
                          street_type: 'Avenue',
                          street_postdirection: 'NW',
                          city: 'Washington',
                          state: 'DC',
                          zip_5: 123
                        )).not_to be_valid
      end
    end

    context 'without a real New York address' do
      let(:address) { create(:address_ny) }
      it 'is invalid' do
        expect(address).to be_valid
      end
    end

    context 'without a real Los Angeles address' do
      let(:address) { create(:address_la) }
      it 'is invalid' do
        expect(address).to be_valid
      end
    end

    context 'without a house number' do
      let(:address) { create(:address_white_house) }
      it 'is invalid' do
        address.house_number = nil
        expect(address).not_to be_valid
      end
    end

    context 'without a street name' do
      let(:address) { create(:address_white_house) }
      it 'is invalid' do
        address.street_name = ''
        expect(address).not_to be_valid
      end
    end

    context 'without a city' do
      let(:address) { create(:address_white_house) }
      it 'is invalid' do
        address.city = nil
        expect(address).not_to be_valid
      end
    end

    context 'without a state' do
      let(:address) { create(:address_white_house) }
      it 'is invalid' do
        address.state = ''
        expect(address).not_to be_valid
      end
    end

    context 'without a zip code' do
      let(:address) { create(:address_white_house) }
      it 'is invalid' do
        address.zip_5 = nil
        expect(address).not_to be_valid
      end
    end

    describe '#to_s' do
      let(:address) { create(:address_ny) }
      it 'prints out the address components needed for mailing together as a string' do
        expect(address.to_s).to eq('129 W 81st St Apt 5A, New York, NY 10024')
      end
      context 'with a unit name' do
        let(:address) { create(:address_la) }
        it 'prints out the correct address components in a single string' do
          expect(address.to_s).to eq('14200 Polk St UNIT 33, Los Angeles, CA 91342')
        end
      end
    end

    describe '#arc_gis_params' do
      let(:address) { create(:address_ny_input) }
      it 'contains the address query string parameter to send to the GIS API' do
        expect(address.arc_gis_params).to match(Regexp.escape('address=129+W+81st+St+Apt+5A'))
      end
      it 'contains the city query string parameter to send to the GIS API' do
        expect(address.arc_gis_params).to match(Regexp.escape('city=New+York'))
      end
      it 'contains the postal query string parameter to send to the GIS API' do
        expect(address.arc_gis_params).to match(Regexp.escape('postal=10024'))
      end
      it 'contains the region query string parameter to send to the GIS API' do
        expect(address.arc_gis_params).to match(Regexp.escape('region=NY'))
      end
    end
  end
end
