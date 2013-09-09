Feature: User profile

  Scenario: I should be able to update my profile
    Given a user "me" exists with email: "ilyakatz@gmail.com"
    And I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    When I follow "Profile"
    And I fill in "First name" with "Ilya"
    And I fill in "Last name" with "Katz"
    And I fill in "Location" with "Brooklyn, NY"
    And I press "Update User"

    Then I should be on the users dashboards page
    And I should see "Brooklyn, NY"

  @javascript
  Scenario: I should be able to update my job title
    Given a user "me" exists with email: "ilyakatz@gmail.com"
    And I login as "ilyakatz@gmail.com"
    And I go to the users profiles page
    And I fill in "Job title" with "Developer"
    And I press "Update User"

  Scenario: Anyone should be able to see pubic profile
    Given a user "ilya" exists with first_name: "Ilya", last_name: "Katz"
    And user "ilya" has complete profile
    When I go to the user "ilya"'s page
    Then I should see "Ilya Katz"

  @javascript
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
