# encoding: UTF-8
FactoryGirl.define do
  factory :lead do
    name "John Doo"
    email "john@cafeazul.com.br"
    phone_code "11"
    phone "50527001"
    address_search "Moema, São Paulo, Brasil"
    latitude -23.605556
    longitude -46.665833
    address
    
    # factory :lead_with_products do
    #   ignore do
    #     products_count 3
    #   end
    # 
    #   after(:create) do |lead, evaluator|
    #     FactoryGirl.create_list :product, evaluator.products_count, lead: lead
    #   end
    # end
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
  
  factory :address do
    sequence(:street) { |n| "rua #{n}" }
    sequence(:complement) { |n| "complemento #{n}" }
    sequence(:city) { |n| "cidade #{n}" }
    sequence(:state) { |n| "S#{n}" }
    sequence(:number) { |n| n }
    sequence(:zipcode) { |n| n }
    sequence(:district) { |n| "bairro #{n}" }
  end
  
  factory :product do
    sequence(:name) { |n| "Produto #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    price 21.99
    # discount 10
    
    franchise
  end
  
  factory :voucher do
    sequence(:code) { |n| "code#{n}" }
    used_at nil
    payment_method 'boleto'
    
    unity
    # lead
    
    factory :voucher_with_line_items do
      ignore do
        line_items_count 1
      end
    
      after(:create) do |voucher, evaluator|
        FactoryGirl.create_list :line_item, evaluator.line_items_count, voucher: voucher
      end
    end
  end
  
  factory :line_item do
    voucher
    product
    
    price 10
  end
end