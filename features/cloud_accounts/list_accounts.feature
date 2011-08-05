Feature: Listing accounts

  Scenario: Listing accounts normally
    Given I am logged in
    And there are some accounts
    When I go to the accounts page
    Then I should see that there are some accounts
