Feature: invite contacts

  Scenario: I want to invite new users
    When I login as "ilya@werkd.net"
    And google returns my contact list
    And I go to import google contacts page
    And I follow "Invite"
    Then I should see "ilya@not-werkd.net invited"
    And 1 email should be delivered to ilya@not-werkd.net
    And the email should contain "Accept Invitation"

  Scenario: I want to connect with existing users
    When I login as "ilya@werkd.net"
    And google returns my contact list
    And I go to import google contacts page
    And I follow "Connect"
    Then I should see "Invitation to connect has been sent"
    And 1 email should be delivered to ilya@werkd.net
    And the email should contain "connect"
