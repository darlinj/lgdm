Feature: Adding an account to access

@wip
  Scenario: Adding an account
    When I go to the new account page
    And I fill in valid account details
    Then I should see that there is a new account
