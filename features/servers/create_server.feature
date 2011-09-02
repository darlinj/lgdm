Feature: Starting servers
  Creating a basic server

  Scenario: creating a server
    Given I am logged in
    And there are server images available
    When I go to the list of images
    And I click the server start button for a particular image
    Then I should see that the server has been started

