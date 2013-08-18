Feature: Invitations

  Scenario: Invite a user
    Given a user exists with email: "ilya@werkd.net", first_name: "ilya", last_name: "katzmopolitan"
    When I login as "ilya@werkd.net"
    And I go to new user invitation page
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send"
    Then 1 email should be delivered to ilyakatz@gmail.com
    And I am not signed in
    When they follow "Accept Invitation" in the email
    And I fill in "Password" with "test123"
    And I fill in "confirmation" with "test123"
    And I press "Set"
    And I fill in "First name" with "ilya"
    And I fill in "Last name" with "gmail"
    And I press "Update"
    And I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    Then I should see "katzmopolitan"

  Scenario: Inviter gets a notification that invitee accepted invitation
    Given a user exists with email: "ilya@werkd.net", first_name: "ilya", last_name: "katzmopolitan"
    When I login as "ilya@werkd.net"
    And I go to new user invitation page
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send"
    Then 1 email should be delivered to ilyakatz@gmail.com
    And I am not signed in
    When they follow "Accept Invitation" in the email
    And I fill in "Password" with "test123"
    And I fill in "confirmation" with "test123"
    And I press "Set"
    And I fill in "First name" with "ilya"
    And I fill in "Last name" with "gmail"
    And I press "Update"
    And I am not signed in
    When I login as "ilya@werkd.net"
    Then 1 email should be delivered to ilya@werkd.net
    And the email should contain "ilyakatz@gmail.com"
    And the email should contain "accepted your invitation"
    And I follow "ilyakatz@gmail.com" in the email
    Then I should see "ilya gmail"

  Scenario: When user accept invitation, they should get a welcome email
    When I login as "ilya@werkd.net"
    And I go to new user invitation page
    And I fill in "Email" with "ilyakatz@gmail.com"
    And I press "Send"
    Then 1 email should be delivered to ilyakatz@gmail.com
    And I am not signed in
    When they follow "Accept Invitation" in the email
    And all emails have been delivered
    And I fill in "Password" with "test123"
    And I fill in "confirmation" with "test123"
    And I press "Set"
    Then 1 email should be delivered to ilyakatz@gmail.com
    And email should contain "Thanks again for being one of the first"

