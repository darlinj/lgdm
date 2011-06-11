Feature: listing images
  Listing the images that are available

  @wip
  Scenario: listing images
    Given there are server images available 
    When I go to the list of images
    Then I should see the list of images
