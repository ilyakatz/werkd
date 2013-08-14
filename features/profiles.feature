Feature: User profile

  Scenario: I should be able to update my profile
    Given a user "me" exists with email: "ilyakatz@gmail.com"
    And I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    When I follow "Profile"
    And I fill in "First name" with "Ilya"
    And I fill in "Last name" with "Katz"
    And I fill in "Location" with "Brooklyn, NY"
    And I press "Update"
    Then I should be on the users dashboards page
    And I should see "Brooklyn, NY"

  Scenario: I should be able to update my job title
    Given a user "me" exists with email: "ilyakatz@gmail.com"
    And I login as "ilyakatz@gmail.com"
    And I go to the users profiles page
    And I fill in "Job title" with "Developer"
    And I press "Update"
    Then I should see "Developer"

  Scenario: I should be able to dashboard if my profile is complete
     Given pending
