Feature: Signing up
  Well derr..

  Scenario: Signup
    When I go to the sign-up form
    And I fill in valid user details
    And I should get an email
    And I click on the link in the email
    Then I should be registered
    And I should be logged in

@wip
  Scenario: Invalid email
    When I go to the sign-up form
    And I fill in a bad email address
    Then I should see an error about the email

@wip
  Scenario: non-matching passwords
    When I go to the sign-up form
    And I fill in a non-matching passwords
    Then I should see an error about non-matching passwords
