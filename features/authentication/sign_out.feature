Feature: Signing out
  Scenario: Signing out
    Given I am logged in
    When I click on the log out link
    And show me the page
    Then I should be logged out

