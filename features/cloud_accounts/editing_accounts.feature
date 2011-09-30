Feature: showing an account to access

  Scenario: Showing an account
    Given I am logged in
    And there are some accounts
    When I go to the accounts page
    And I select an account
    Then I should see the details of the account
    When I change a value
    Then I should see that the value has changed
