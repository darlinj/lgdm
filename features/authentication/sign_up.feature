Feature: Signing up
  Well derr..

  Scenario: Signup
    When I go to the sign-up form
    And I fill in valid user details
    And I should get an email
    And I click on the link in the email
    Then I should be registered

