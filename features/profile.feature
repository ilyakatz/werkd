Feature: Public profile

  Scenario: Anyone should be able to see pubic profile
    Given a user "ilya" exists with first_name: "Ilya", last_name: "Katz"
    And user "ilya" has complete profile
    When I go to the user "ilya"'s page
    Then I should see "Ilya Katz"
