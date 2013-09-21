Feature: Homepage

  Scenario: I should be able signup from the homepage
    When I go to the homepage
    And I fill in "Email" with "nobod@wrkd.net"
    And I fill in "Password" with "secret"
    And I press "Let's get started"
    Then I should see "Welcome! You have signed up successfully"

  @javascript
  Scenario: I should be able to login from the homepage
    Given a user exists with email: "nobody@werkd.net", password: "secret"
    When I go to the homepage
    And I click within "[data-role='existing-user']"
    Then I should see "Welcome back"
    When I fill in "Email" with "nobody@werkd.net"
    And I fill in "Password" with "secret"
    And I press "Sign in"
    Then I should see "Signed in successfully"

  Scenario: Logged in users should be redirected to the dashboard
    Given I login as "ilya@werkd.net"
    When I go to the homepage
    Then I should be on the users dashboards page
