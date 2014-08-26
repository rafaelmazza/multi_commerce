# encoding: UTF-8

# franchise
franchise = Franchise.find_or_create_by_name(name: 'wizard', url: 'promocao.wizard.com.br', acronym: 'W', title: 'Wizard Idiomas')

# products
Product.find_or_create_by_name(name: 'Curso de inglês', description: 'Curso de inglês.', price: 199.99, franchise: franchise)

# timetables
Timetable.find_or_create_by_title(title: 'Manhã', description: 'Período matutino')
Timetable.find_or_create_by_title(title: 'Tarde', description: 'Período vespertino')
Timetable.find_or_create_by_title(title: 'Noite', description: 'Período noturno')
Timetable.find_or_create_by_title(title: 'Flex', description: 'Qualquer horário')

# campaigns
%w(google facebook italiano chines frances espanhol japones alemao maosaobra).each do |name|
  Campaign.find_or_create_by_name(name: name, franchise_id: franchise.id)
end

# backend user
BackendUser.find_or_create_by_email(email: 'rafael@cafeazul.com.br', password: '1234568')