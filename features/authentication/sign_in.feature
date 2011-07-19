Feature: Login in

  Scenario: Login
    Given there is a user
    When I go to the login form
    And I fill in valid login details
    Then I should be logged in
