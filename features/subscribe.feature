Feature: Lead subscribe
  Background:
    # Given the following course_periods exists:
    #   | title | description     |
    #   | Manhã | Estude de Manhã |
    #   | Tarde | Estude de Tarde |
    #   | Noite | Estude de Noite |
    #   | Flex  | Estude de Flex  |
    # And the following courses exists:
    #   | name     |
    #   | Inglês   |
    #   | Espanhol |
    # And the server respond near unity with name: "Nome da unidade", address: "Endereço da unidade", phone: "123123"

  # @javascript
  Scenario: Basic subscription
    Given I am on the home page
    When I fill the subscribe form with valid lead data

    # Then I should see "Você está em:"
    # And the lead should exist with name: "Fulano de Tal", email: "fulano@tal.com", phone: "77778888", ddd: "11"
    # 
    # When I press "Manhã"
    # And I wait "1"
    # Then the lead with name: "Fulano de Tal" should have a course_period with title: "Manhã"
    # 
    # When I select "Espanhol" from "lead_course_id"
    # And I wait "1"
    # Then the lead with name: "Fulano de Tal" should have a course with name: "Espanhol"

  # @javascript
  # Scenario: Voucher
  #   Given I am on the home page
  #   And voucher generator responds with "my voucher code"
  # 
  #   When I fill in "Nome" with "Cliente"
  #   And I fill in "Email" with "cliente@escola.com.br"
  #   And I fill in "DDD" with "21"
  #   And I fill in "Telefone" with "1111-2222"
  #   And I press "Inscreva-se Já!"
  #   And I press "Manhã"
  #   And I select "Inglês" from "lead_course_id"
  #   And I press "Imprimir voucher e ir até a unidade"
  # 
  #   Then I should see "Cliente"
  #   And I should see "cliente@escola.com.br"
  #   And I should see "21"
  #   And I should see "11112222"
  #   And I should see "Nome da unidade"
  #   And I should see "Endereço da unidade"
  #   And I should see "my voucher code"
