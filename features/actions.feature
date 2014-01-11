Feature: Page with pending connections

  Scenario: I should be able to see a pending connection for the page
    Given a user "inviter" exists with email: "ilya@werkd.net", first_name: "Inviter"
    And a user "invitee" exists with email: "ilyakatz@gmail.com", first_name: "Invitee"
    And a connection exists with invitee: user "invitee", inviter: user "inviter"
    When I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    And I follow "Connections approvals"
    And I should see "Inviter"

  Scenario: I should be able to see a pending connection for the page
    Given a user "inviter" exists with email: "ilya@werkd.net", first_name: "Inviter"
    And a user "invitee" exists with email: "ilyakatz@gmail.com", first_name: "Invitee"
    And a connection exists with invitee: user "invitee", inviter: user "inviter"
    And all emails have been delivered
    When I login as "ilyakatz@gmail.com"
    And I go to the users actions page
    And I follow "Accept"
    And I follow "Connections approvals"
    Then I should see "No pending connections at this time"
    And 1 email should be delivered with to: "ilya@werkd.net", subject: "Connection invitation Accepted"
