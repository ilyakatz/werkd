Feature: connections

  Scenario: I should be able to log out
    When I login as "ilya@werkd.net"
    And I go to the users dashboards page
    And I follow "Sign out"
    Then I should see "Signed out successfully"


