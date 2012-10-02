# encoding: UTF-8
Given /^I am on the home page$/ do
  visit root_path
end

When /^I fill the subscribe form with valid lead data$/ do
  fill_in "Nome", with: "Rafael Mazza"
  fill_in "Email", with: "rafael@cafeazul.com.br"
  fill_in "DDD", with: "11"
  fill_in "Telefone", with: "50727001"
  fill_in "Localização", with: "São Paulo"
  click_on "Inscreva-se já!"
end