Feature: connections

  Scenario: When I send an invitation it shouold show up as pending
    When I login as "ilya@werkd.net"
    And I go to new user invitation page
    And a user exists with email: "ilyakatz@gmail.com", password: "password123"
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send"
    And I follow "Connections"
    And I should see "ilyakatz@gmail.com"
    And I should see "pending"

  Scenario: I send an invitation to existing user to create a meangful connection
    When I login as "ilya@werkd.net"
    And I go to new user invitation page
    And a user exists with email: "ilyakatz@gmail.com", password: "password123"
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send"
    And I should see "Invitation to connect has been sent"

  Scenario: I accept connection invitation
    When I login as "ilya@werkd.net"
    And I go to new user invitation page
    And a user exists with email: "ilyakatz@gmail.com", password: "password123"
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send"
    Then 1 email should be delivered to ilyakatz@gmail.com
    And I am not signed in
    When I login as "ilyakatz@gmail.com"
    When they follow "Yes" in the email
    And I follow "Connections"
    Then I should see "ilya@werkd.net"
    And I should not see "pending"

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
    And a user exists with email: "ilyakatz@gmail.com", password: "password123"
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send"
    Then 1 email should be delivered to ilyakatz@gmail.com
    And I am not signed in
    When I login as "ilyakatz@gmail.com"
    When they follow "Yes" in the email
    Then I am not signed in
    When I login as "ilya@werkd.net"
    And I go to users connections page
    Then I should see "ilyakatz@gmail.com"
    And I should not see "pending"

 Scenario: Inviter gets an email when invitee accepts invitation
    When I login as "ilya@werkd.net"
    And I go to new user invitation page
    And a user exists with email: "ilyakatz@gmail.com", password: "password123"
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send"
    Then 1 email should be delivered to ilyakatz@gmail.com
    And I am not signed in
    When I login as "ilyakatz@gmail.com"
    When they follow "Yes" in the email
    Then 1 email should be delivered to ilya@werkd.net
