Feature: Listing chef accounts

  Scenario: Listing accounts normally
    Given I am logged in
    And there are some chef accounts
    When I go to the chef accounts page
    Then I should see that there are some chef accounts
