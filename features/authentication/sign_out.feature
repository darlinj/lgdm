Feature: Signing out
  Scenario: Signing out
    Given I am logged in
    When I click on the log out link
    Then I should be logged out

