Feature: Projects

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
