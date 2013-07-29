Feature: Invitations

  Scenario: Invite a user
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
    And I follow "Connections"
    Then I should see "ilya@werkd.net"

  Scenario: Inviter gets a notification that invitee accepted invitation
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
    And I am not signed in
    When I login as "ilya@werkd.net"
    Then 1 email should be delivered to ilya@werkd.net
    And the email should contain "ilyakatz@gmail.com"
    And I follow "ilyakatz@gmail.com" in the email
    Then I should see "ilyakatz@gmail.com"

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

  Scenario: I should be able to list my projects
    Given a user "me" exists with email: "ilyakatz@gmail.com"
    And a project "project" exists with user: user "me", title: "Cool project"
    And I login as "ilyakatz@gmail.com"
    When I go to the users dashboards page
    And I follow "Projects"
    Then I should see "Cool project"

  Scenario: I should be able to add a new project
    When I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    And I follow "Projects"
    And I follow "New Project"
    And I fill in "Title" with "New Project"
    And I fill in "Company" with "Coca Cola"
    And I press "Create"
    Then I should see "Project was successfully created"
    And I go to the users dashboards page
    And I follow "Projects"
    And I should see "New Project"
    And I should see "Coca Cola"

  Scenario: I should be able to edit a project
    Given a user "me" exists with email: "ilyakatz@gmail.com"
    And a project "project" exists with user: user "me", title: "Cool project"
    And I login as "ilyakatz@gmail.com"
    When I go to the users dashboards page
    And I follow "Projects"
    And I follow "Edit"
    And I fill in "Title" with "New cool project"
    And I press "Update"
