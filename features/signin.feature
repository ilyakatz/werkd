Feature: Signing up and signin in
 In order to have a system with permissions
 As a Werkd user
 I want to be able to sign up and sign in to WeRKD

  Scenario: I should be able to log out
    When I login as "ilya@werkd.net"
    And I go to the users dashboards page
    And I follow "Sign out"
    Then I should see "Signed out successfully"

  Scenario: I should be able to sign up
    When I go to the root page
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I fill in "Password" with "secret"
    And I press "Let's get started"
    Then I should be on the users profiles page
    And 1 email should be delivered to "ilyakatz@gmail.com"

  Scenario: After sign in, completing profile and contacts I should be taken to add projects_controller
    Given a user "me" exists with email: "ilyakatz@gmail.com"
    And user "me" has basic profile
    And user "me" invited_contacts
    When I login as "ilyakatz@gmail.com"
    When I go to the new user session page
    Then I should be on the new users project page

  Scenario: After I signin I should be taken to dashboard page if my profile is compelete
    Given a user "me" exists with email: "ilyakatz@gmail.com", password: "secret"
    And user "me" has complete profile
    When I go to the new user session page
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I fill in "Password" with "secret"
    And I press "Sign in"
    Then I should be on the users feeds page

  @wip
  Scenario: After I signup with facebook I should be taken to the profiles page
    And pending
