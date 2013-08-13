Feature: User profile

  Scenario: I should be see unknown location if I didn't set it up
    Given a user "me" exists with email: "ilyakatz@gmail.com"
    And I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    Then I should see "Unknown" within ".location"

  Scenario: I should my location
    Given a user "me" exists with email: "ilyakatz@gmail.com", location: "Brooklyn"
    And I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    Then I should see "Brooklyn" within ".location"
