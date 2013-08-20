Feature: User profile

  Scenario: I should not see a location if I didn't set it up
    Given a user "me" exists with email: "ilyakatz@gmail.com"
    And I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    Then there should be 0 ".location"

  Scenario: I should my location
    Given a user "me" exists with email: "ilyakatz@gmail.com", location: "Brooklyn"
    And I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    Then I should see "Brooklyn" within ".location"

  Scenario: I should not see job title if it is not present
    Given a user "me" exists with email: "ilyakatz@gmail.com"
    And I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    Then there should be 0 ".job_title"

  Scenario: I should my location
    Given a user "me" exists with email: "ilyakatz@gmail.com", job_title: "Developer"
    And I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    Then I should see "Developer" within ".job-title"
