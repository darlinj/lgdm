Feature: Signing out
  Scenario: Signing out
    Given I am logged in
    And I am on the homepage
    When I click on the log out link
    Then I should be logged out

