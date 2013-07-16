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
    Then 1 email should be delivered to ilyakatz@gmail.com
    And I am not signed in
    When I login as "ilyakatz@gmail.com"
    When they follow "here" in the email
    Then I should see "ilya@werkd.net"
    And I should not see "pending"
    #When I login as "ilya@werkd.net"
    #And I go to new users connection page


  Scenario: I accept connection invitation
