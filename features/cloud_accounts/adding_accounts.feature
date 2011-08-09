Feature: Adding an account to access

  Scenario: Adding an account
    Given I am logged in
    When I go to the new account page
    And I fill in valid account details
    Then I should see that there is a new account

  Scenario: Adding an account
    Given I am logged in
    When I go to the new account page
    And I fill in INVALID account details
    Then I should see that the create has failed
