Feature: Public profile

  Scenario: Anyone should be able to see pubic profile
    Given a user "ilya" exists with first_name: "Ilya", last_name: "Katz"
    And user "ilya" has complete profile
    When I go to the user "ilya"'s page
    Then I should see "Ilya Katz"

  Scenario: I should be able to see users contacts from their profile
    Given a user "ilya" exists with first_name: "Ilya"
    Given a user "will" exists with first_name: "Will"
    And user "ilya" has a connection user "will"
    When I go to the user "ilya"'s page
    Then I should see "Ilya" within ".name"
    And I follow "Will"
    Then I should see "Will" within ".name"
    And I follow "Ilya"
    Then I should see "Ilya" within ".name"
