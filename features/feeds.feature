Feature: My feeds

  Scenario: I should be able to access my feeds
    Given I login as "ilya@werkd.net"
    When I go to the users dashboards page
    And I follow "Home"
    Then I should see "What's up?"
