FactoryBot.define do
  factory :address do
    # 129 W 81st St Apt 5A, New York, NY 10024
    factory :address_ny do
      house_number '129'
      street_predirection 'W'
      street_name '81st'
      street_type 'St'
      unit_type 'Apt'
      unit_number '5A'
      city 'New York'
      state 'NY'
      zip_5 '10024'
    end
    # 129 W 81st St Apt 5A, New York, NY 10024 (input by user)
    factory :address_ny_input do
      street_address '129 W 81st St Apt 5A'
      city 'New York'
      state 'NY'
      zip_code '10024'
    end
    # 1600 Pennsylvania Avenue NW, Washington, DC 20500
    factory :address_white_house do
      house_number 1600
      street_name 'Pennsylvania'
      street_type 'Avenue'
      street_postdirection 'NW'
      city 'Washington'
      state 'DC'
      zip_5 20500
    end
    # 14200 Polk St UNIT 33, Los Angeles, CA 91342
    factory :address_la do
      house_number 14200
      street_name 'Polk'
      street_type 'St'
      unit_type 'UNIT'
      unit_number '33'
      city 'Los Angeles'
      state 'CA'
      zip_5 91342
    end
  end
end
