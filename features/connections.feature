  Feature: connections

  @javascript
  Scenario: When I send an invitation it should show up as pending
    Given a user exists with email: "ilya@werkd.net", first_name: "Ilya"
    When I login as "ilya@werkd.net"
    And I go to new user invitation page
    And a user exists with email: "ilyakatz@gmail.com", password: "password123", first_name: "Ilya", last_name: "Morpheus"
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send an invitation"
    Then I should be on the users profiles page
    And I go to the users dashboards page
    And I should see "Ilya Morpheus"

  Scenario: I send an invitation to existing user to create a meangful connection
    When I login as "ilya@werkd.net"
    And I go to new user invitation page
    And a user exists with email: "ilyakatz@gmail.com", password: "password123"
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send an invitation"
    And I should see "Invitation to connect has been sent"

  Scenario: I accept connection invitation
    Given a user exists with email: "ilya@werked.net"
    When I login as "ilya@werkd.net"
    And I go to new user invitation page
    And a user exists with email: "ilyakatz@gmail.com", password: "password123", first_name: "Ilya", last_name: "Morpheus"
    And all emails have been delivered
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send"
    Then 1 email should be delivered to ilyakatz@gmail.com
    And I am not signed in
    When I login as "ilyakatz@gmail.com"
    When they follow "Yes" in the email
    And I should see "Ilya Morpheus"

  Scenario: Do not send a duplicate invitation
    When I login as "ilya@werkd.net"
    And I go to new user invitation page
    And a user exists with email: "ilyakatz@gmail.com", password: "password123"
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send"
    And I go to new user invitation page
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send"
    And I should see "You already invited ilyakatz@gmail.com"

 Scenario: Inviter can see that invitee accepted the invitation
    When I login as "ilya@werkd.net"
    And I go to new user invitation page
    And a user exists with email: "ilyakatz@gmail.com", password: "password123", first_name: "Katzo"
    And all emails have been delivered
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send"
    Then 1 email should be delivered to ilyakatz@gmail.com
    And I am not signed in
    When I login as "ilyakatz@gmail.com"
    When they follow "Yes" in the email
    Then I am not signed in
    When I login as "ilya@werkd.net"
    And I go to the users dashboards page
    Then I should see "Katzo"

 Scenario: Inviter gets an email when invitee accepts invitation
    When I login as "ilya@werkd.net"
    And a user exists with email: "ilyakatz@gmail.com", password: "password123"
    And I go to new user invitation page
    And all emails have been delivered
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send"
    Then 1 email should be delivered to ilyakatz@gmail.com
    And I am not signed in
    When I login as "ilyakatz@gmail.com"
    When they follow "Yes" in the email
    Then 1 email should be delivered to ilya@werkd.net

  @javascript
  Scenario: I should be able to invite friends from the dashboard
    When I login as "ilya@werkd.net"
    When I go to the users dashboards page
    And I follow "Invite a friend"
    Then I should see "Let's invite people"

