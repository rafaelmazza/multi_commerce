require 'spec_helper'

describe Lead do
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:email).of_type(:string) }
  it { should have_db_column(:phone_code).of_type(:string) }
  it { should have_db_column(:phone).of_type(:string) }
  it { should have_db_column(:address_search).of_type(:string) }
  
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:email) }  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone_code) }  
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:address_search) }  
  it { should validate_numericality_of(:phone_code) }
  it { should validate_numericality_of(:phone) }
end