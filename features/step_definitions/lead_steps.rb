# encoding: UTF-8
Given /^there are a bunch unities$/ do
  create_unities
  Unity.stub(:near).and_return(@unities)
end

def create_unities
  @unities ||= 3.times.map { create(:unity) }
end

Given /^I am on the home page$/ do
  visit root_path
end

When /^I fill the subscribe form with valid lead info and submit$/ do
  fill_in "Nome", with: "Rafael Mazza"
  fill_in "Email", with: "rafael@cafeazul.com.br"
  fill_in "DDD", with: "11"
  fill_in "Telefone", with: "50727001"
  fill_in "Localização", with: "Moema"  
  # sleep 1
  click_on "Inscreva-se já!"
end

Then /^I see the list of unities near me$/ do
  page.should have_xpath("//div[@class='unity']")
end

When /^I click subscribe on the first found unity$/ do
  find('a.subscribe:first').click
end

Then /^I see the payment form$/ do
  page.should have_xpath("//div[@id='payment']")
end