Feature: listing images
  Listing the images that are available

  Scenario: listing images
    Given I am logged in
    And there are server images available
    When I go to the list of images
    Then I should see the list of images
    And I should not see images that are not machines

  Scenario: Trying to list images when there is no cloud account configured
    Given I am logged in
    When I go to the list of images
    Then I should see that there are no images available
