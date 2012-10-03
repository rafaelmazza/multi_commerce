require 'spec_helper'

describe Unity do
  it { should have_db_column(:code).of_type(:string) }
  it { should have_db_column(:franchise_acronym).of_type(:string) }  
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:status).of_type(:string) }
  it { should have_db_column(:situation).of_type(:string) }
  it { should have_db_column(:email).of_type(:string) }
  it { should have_db_column(:phone).of_type(:string) }
  it { should have_db_column(:address).of_type(:string) }
end