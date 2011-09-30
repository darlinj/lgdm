Feature: showing an account to access

  Scenario: Showing an account
    Given I am logged in
    And there are some chef accounts
    When I go to the chef accounts page
    And I select a chef account
    Then I should see the details of the chef account
    When I change a value for chef
    Then I should see that the chef account value has changed
