# encoding: UTF-8
FactoryGirl.define do
  factory :lead do
    name "John Doo"
    email "john@cafeazul.com.br"
    phone_code "11"
    phone "99119911"
    address_search "Moema, São Paulo"
    # latitude 37.0625
    # longitude -95.677068
  end
end