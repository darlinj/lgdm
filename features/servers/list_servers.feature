Feature: listing servers

  Background:
    Given I am logged in

  Scenario: Basic list of servers from the cloud account
    Given there are some servers on the cloud
    When I go to the list of servers
    Then I should see the servers

