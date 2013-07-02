Feature: Invitations

  Scenario: Invite a user
    When I login as "ilya@werkd.net"
    And I go to new user invitation page
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send"
    Then 1 email should be delivered to ilyakatz@gmail.com
    And I am not signed in
    When they follow "Accept" in the email
    And I fill in "Password" with "test123"
    And I fill in "confirmation" with "test123"
    And I press "Set"
    And I follow "Connections"
    Then I should see "ilya@werkd.net"

  Scenario: Inviter gets a notification that invitee accepted invitation
    When I login as "ilya@werkd.net"
    And I go to new user invitation page
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send"
    Then 1 email should be delivered to ilyakatz@gmail.com
    And I am not signed in
    When they follow "Accept" in the email
    And I fill in "Password" with "test123"
    And I fill in "confirmation" with "test123"
    And I press "Set"
    And I am not signed in
    When I login as "ilya@werkd.net"
    Then 1 email should be delivered to ilya@werkd.net
    And the email should contain "ilyakatz@gmail.com"
    And I follow "here" in the email
    Then I should see "ilyakatz@gmail.com"

  Scenario: When user accept invitation, they should get a welcome email
    Given PENDING
