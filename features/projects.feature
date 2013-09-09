Feature: Projects

  Scenario: I should be able to list my projects
    Given a user "me" exists with email: "ilyakatz@gmail.com"
    And a project "project" exists with creator: user "me", title: "Cool project"
    And I login as "ilyakatz@gmail.com"
    When I go to the users dashboards page
    Then I should see "Cool project"

  Scenario: I should be able to add a new project
    When I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    And I click ".icon-plus-sign" icon within ".new-project"
    And I fill in "Title" with "New Project"
    And I fill in "Company" with "Coca Cola"
    And I fill in "Tags" with "Design"
    And I press "Create"
    And I go to the users dashboards page
    And I should see "New Project"

  Scenario: I should be able to edit a project
    Given a user "me" exists with email: "ilyakatz@gmail.com"
    And a project "project" exists with creator: user "me", title: "Cool project"
    And I login as "ilyakatz@gmail.com"
    When I go to the users dashboards page
    And I follow "Cool project"
    And I follow "Edit"
    And I fill in "Title" with "New cool project"
    And I press "Update"

  Scenario: I should be able to add my contribution
    When I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    And I click ".icon-plus-sign" icon within ".new-project"
    And I fill in "Title" with "New Project"
    And I fill in "Company" with "Coca Cola"
    And I fill in "Tags" with "Design"
    And I fill in "Contribution" with "Slacked off, mostly"
    And I press "Create"
    Then a project should exist with contribution: "Slacked off, mostly"

  Scenario: I should be able to add tags to a project
    When I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    And I click ".icon-plus-sign" icon within ".new-project"
    And I fill in "Title" with "New Project"
    And I fill in "Company" with "Coca Cola"
    And I fill in "Tags" with "Design"
    And I fill in "Tags" with "graphic design"
    And I press "Create"
    Then a project should exist
    When I go to the project's page
    Then I should see "graphic design"

  Scenario: I should be able to add project date
    When I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    And I click ".icon-plus-sign" icon within ".new-project"
    And I fill in "Title" with "New Project"
    And I fill in "Company" with "Coca Cola"
    And I fill in "Tags" with "Design"
    And I select "2012" from "project_start_at_1i"
    And I select "May" from "project_start_at_2i"
    And I press "Create"
    Then a project should exist
    When I go to the project's page
    Then I should see "May 01, 2012"

  Scenario: I should be able to tag people on a project
    And a user "coworker" exists with email: "coworker@werkd.com", first_name: "Worker"
    When I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    And I click ".icon-plus-sign" icon within ".new-project"
    And I fill in "Title" with "New Project"
    And I fill in "Company" with "Coca Cola"
    And I fill in "Tags" with "Design"
    And I tag user "coworker" on the project
    And I press "Create"
    Then a project should exist
    When I go to the project's page
    Then I should see "Worker"
    And I should see "coworker@werkd.com"

  Scenario: Visitor should not be able to see emails
    When I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    And I click ".icon-plus-sign" icon within ".new-project"
    And I fill in "Title" with "New Project"
    And I fill in "Company" with "Coca Cola"
    And I fill in "Tags" with "Design"
    And I fill in "Collaborators" with "cowerker@werked.net"
    And I press "Create"
    Then a project should exist
    And I am not signed in
    When I go to the project's page
    And I should not see "cowerker@werked.net"

  Scenario: Visitors shouold able to see accepted collaborators
    Given a user "me" exists with first_name: "Ilya"
    And a project "p" exists with title: "My project", creator: user "me"
    And a collaboration exists with collaborator: user "me", project: project "p", accepted_at: "10 Dec 2013"
    And I go to user "me"'s page
    And I follow "My project preview"
    And I should see "Ilya"

  Scenario: Visitors shouold not be able to see pending Collaborators
    Given a user "me" exists with first_name: "Ilya"
    And a project "p" exists with title: "My project", creator: user "me"
    And a collaboration exists with collaborator: user "me", project: project "p"
    And I go to user "me"'s page
    And I follow "My project preview"
    And I should not see "Ilya"

  Scenario: I should be able to tag new people by their email address
    When I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    And I click ".icon-plus-sign" icon within ".new-project"
    And I fill in "Title" with "New Project"
    And I fill in "Company" with "Coca Cola"
    And I fill in "Tags" with "Design"
    And I fill in "Collaborators" with "cowerker@werked.net"
    And I press "Create"
    Then a project should exist
    When I go to the project's page
    Then I should see "WeRKD user"

  Scenario: I am required to enter a few projects
    When I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    And I click ".icon-plus-sign" icon within ".new-project"
    And I fill in "Title" with "New Project"
    And I fill in "Company" with "Coca Cola"
    And I fill in "Tags" with "Design"
    And I press "Create"
    Then I should see "Please add one more project"
    When I fill in "Title" with "New Project"
    And I fill in "Company" with "Coca Cola"
    And I fill in "Tags" with "Design"
    And I press "Create"
    Then I should see "Please add one more project"
    When I fill in "Title" with "New Project"
    And I fill in "Company" with "Coca Cola"
    And I fill in "Tags" with "Design"
    And I press "Create"
    Then I should be on the users dashboards page
    And I should see "Project was successfully created."

  Scenario: A visitor should be able to view a project
    Given a project exists with title: "Cool project", company: "Coca Kola"
    When I go to the project's page
    Then I should see "Cool project"

  Scenario: A visitor should not be able to see edit link for a project
    Given a project exists with title: "Cool project", company: "Coca Kola"
    When I go to the project's page
    Then I should not see "Edit"
