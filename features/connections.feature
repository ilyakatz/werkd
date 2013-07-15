Feature: connections

  Scenario: I send an invitation to existing user to create a meangful connection
    When I login as "ilya@werkd.net"
    And I go to new user invitation page
    And a user exists with email: "ilyakatz@gmail.com"
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send"
    And I should see "Invitation to connect has been sent"
    And show me the page
    Then 1 email should be delivered to ilyakatz@gmail.com
    #And I am not signed in
    #When they follow "Let's get to WeRKD!" in the email
    #And I fill in "Password" with "test123"
    #And I fill in "confirmation" with "test123"
    #And I press "Set"
    #And I follow "Connections"
    #Then I should see "ilya@werkd.net"
    #When I login as "ilya@werkd.net"
    #And I go to new users connection page


  Scenario: I accept connection invitation
