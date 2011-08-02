Feature: Login in

  Scenario: Login
    Given there is a user
    When I go to the login form
    And I fill in valid login details
    Then I should be logged in

  Scenario: Access a protected page
    Given there is a user
    And there are server images available
    When I go to the list of images
    Then I should be on the sign in page
    When I fill in valid login details
    Then I should be on the images page
    And I should be logged in

  Scenario: failing to log in
    Given there is a user
    When I enter the wrong password
    Then I should see a log in failure message
    And I should be on the sign in page

