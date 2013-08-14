Feature: connections

  Scenario: I should be able to log out
    When I login as "ilya@werkd.net"
    And I go to the users dashboards page
    And I follow "Sign out"
    Then I should see "Signed out successfully"


  Scenario: I should be able to sign up
    When I go to the root page
    And I follow "Join now"
    And I fill in "Email" with "ilykatz@gmail.com"
    And I fill in "Password" with "secret"
    And I fill in "confirmation" with "secret"
    And I press "Let's get started"
    Then I should be on the users profiles page

  Scenario: After I signup, I should be taken to my profile
    When I go to the users registrations page
    And I fill in "Email" with "ilykatz@gmail.com"
    And I fill in "Password" with "secret"
    And I fill in "confirmation" with "secret"
    And I press "Let's get started"
    When I fill in "First name" with "Ilya"
    And I fill in "Last name" with "Katz"
    And I fill in "Job title" with "dev"
    And I fill in "Location" with "New York"
    And I press "Update User"
    And I should be on the new users project page

  Scenario: After I signin I should be taken to dashboard page if my profile is compelete
    And pending
