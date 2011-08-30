Feature: Adding a chef account

  Scenario: Adding an chef account
    Given I am logged in
    When I go to the new chef account page
    And I fill in valid chef account details
    Then I should see that there is a new chef account

  Scenario: Failing to add an account
    Given I am logged in
    When I go to the new chef account page
    And I fill in INVALID chef account details
    Then I should see that the create has failed
