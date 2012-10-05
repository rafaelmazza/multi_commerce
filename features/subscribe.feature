Feature: Lead subscribe
  # Background:
  #   Given there are a bunch unities

  @javascript
  Scenario: Basic subscription - Part 1
    Given there are a bunch unities
    And I am on the home page
    When I fill the subscribe form with valid lead info and submit
    Then I see the list of unities near me

    When I click subscribe on the first found unity
    Then I see the payment form