# encoding: UTF-8
Given /^there are a bunch unities$/ do
  create_unities
end

def create_unities
  @unities ||= 5.times.map { create :unity, latitude: -23.6055556, longitude: -46.6658333 }
end

Given /^I am on the home page$/ do
  visit root_path
end

When /^I fill the subscribe form with valid lead info and submit$/ do
  fill_in "Nome", with: "Rafael Mazza"
  fill_in "Email", with: "rafael@cafeazul.com.br"
  fill_in "DDD", with: "11"
  fill_in "Telefone", with: "50727001"
  fill_in "Localização", with: "Moema, São Paulo"  
  sleep 1
  page.find(".pac-container .pac-item:first").click
  # page.driver.wait_until(page.driver.browser.switch_to.alert.accept)
  find("#address-search-field").native.send_keys(:return)
  # p find(".pac-item:first").text
  click_on "Inscreva-se já!"
end

Then /^I see the list of unities near me$/ do
  page.all('.unity').count.should == 5
end

When /^I click subscribe on the first found unity$/ do
  find('a.subscribe:first').click
end

Then /^I see the payment form$/ do
  page.should have_xpath("//div[@id='payment']")
end