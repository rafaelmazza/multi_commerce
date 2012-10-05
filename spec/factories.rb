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
  
  factory :unity do
    sequence(:code) {|n| "00#{n}"}
    sequence(:name) {|n| "Unidade #{n}"}
    sequence(:address) {|n| "address #{n}"}
    sequence(:email) {|n| "school#{n}@cafeazul.com.br"}
    sequence(:phone) {|n| "phone #{n}"}
    status "4"
    situation "2"
    leads_count 0
  end
  
  factory :franchise do
    name 'wizard'
    url 'desconto.wizard.dev.br'
    acronym 'W-'
  end
end