Feature: Projects

  @javascript
  Scenario: I should be able to list my projects
    Given a user "me" exists with email: "ilyakatz@gmail.com"
    And user "me" created project "Cool project"
    And I login as "ilyakatz@gmail.com"
    When I go to the users dashboards page
    Then I should see "Cool project"

  @javascript
  Scenario: I should be able to add a new project
    When I login as "ilyakatz@gmail.com"
    And I go to the users dashboards page
    And I click ".icon-plus-sign" icon within ".new-project"
    Then I should be on the new users project page

  @javascript
  Scenario: I should be able to edit a project
    Given a user "me" exists with email: "ilyakatz@gmail.com"
    And user "me" created project "Cool project"
    And I login as "ilyakatz@gmail.com"
    When I go to the users dashboards page
    And I follow "Cool project"
    And I follow "Edit"
    And I fill in "Project title" with "New cool project"
    And I press "Update"

  Scenario: I should be able to add my contribution
    When I login as "ilyakatz@gmail.com"
    And I go to the new users project page
    And I fill in "Project title" with "New Project"
    And I fill in "Company" with "Coca Cola"
    And I fill in "Skills used" with "Design"
    And I fill in "Contribution" with "Slacked off, mostly"
    And I press "Create"
    Then a project should exist with contribution: "Slacked off, mostly"

  @javascript
  Scenario: I should be able to add tags to a project
    When I login as "ilyakatz@gmail.com"
    And I go to the new users project page
    And I fill in "Project title" with "New Project"
    And I fill in "Company" with "Coca Cola"
    And I fill in skill "graphic design"
    And I press "Create"
    When I go to the users dashboards page
    And I follow "New Project preview"
    Then I should see "graphic design"

  @javascript
  Scenario: I should be able to add project date
    When I login as "ilyakatz@gmail.com"
    And I go to the new users project page
    And I fill in "Project title" with "New Project"
    And I fill in "Company" with "Coca Cola"
    And I select "2012" from "project_start_at_1i"
    And I select "May" from "project_start_at_2i"
    And I press "Create"
    When I go to the users dashboards page
    And I click within ".project-model-link"
    #WIP
    #Then I should see "May 01, 2012"

  @javascript
  Scenario: I should be able to tag people on a project
    And a user "coworker" exists with email: "coworker@werkd.com", first_name: "Worker"
    When I login as "ilyakatz@gmail.com"
    And I go to the new users project page
    And I fill in "Project title" with "New Project"
    And I fill in "Company" with "Coca Cola"
    And I fill in skill "graphic design"
    And I tag user "coworker" on the project
    And I press "Create"
    When I go to the users dashboards page
    And I click within ".project-model-link"
    Then I should see "Worker"
    And I should see "coworker@werkd.com"

  @javascript
  Scenario: Visitor should not be able to see collaborators' emails
    And a user "me" exists with first_name: "Ilya"
    And a user "collaborator" exists with email: "cowerker@werked.net"
    And a project "p" exists with title: "My project", creator: user "me"
    And a collaboration exists with collaborator: user "collaborator", project: project "p"
    When I go to user "me"'s page
    Then I should not see "cowerker@werked.net"

  @javascript
  Scenario: Visitors should able to see accepted collaborators
    Given a user "me" exists with first_name: "Ilya"
    Given a user "collaborator" exists with first_name: "Collaborator"
    And a project "p" exists with title: "My project", creator: user "me"
    And a collaboration exists with collaborator: user "collaborator", project: project "p", accepted_at: "10 Dec 2013"
    And I go to user "me"'s page
    And I follow "My project preview"
    Then I should see "Collaborator"

  @javascript
  Scenario: I should should be able to see pending Collaborators
    Given a user "me" exists with first_name: "Ilya", email: "ilyakatz@gmail.com"
    Given a user "collaborator" exists with first_name: "Collaborator", last_name: ""
    And a project "p" exists with title: "My project", creator: user "me"
    And a collaboration exists with collaborator: user "collaborator", project: project "p"
    When I login as "ilyakatz@gmail.com"
    And I go to user "me"'s page
    And I follow "My project preview"
    Then I should see "Collaborator (pending)"

  @javascript
  Scenario: Visitors should not be able to see pending Collaborators
    Given a user "me" exists with first_name: "Ilya"
    Given a user "collaborator" exists with first_name: "Collaborator"
    And a project "p" exists with title: "My project", creator: user "me"
    And a collaboration exists with collaborator: user "collaborator", project: project "p"
    And I go to user "me"'s page
    And I follow "My project preview"
    Then I should not see "Collaborator"

  Scenario: I should be able to tag new people by their email address
    When I login as "ilyakatz@gmail.com"
    And I go to the new users project page
    And I fill in "Project title" with "New Project"
    And I fill in "Company" with "Coca Cola"
    And I fill in "Skills used" with "Design"
    And I fill in "Collaborators" with "cowerker@werked.net"
    And I press "Create"
    Then a project should exist
    When I go to the project's page
    Then I should see "WeRKD user"

  Scenario: I am required to enter a few projects
    When I login as "ilyakatz@gmail.com"
    And I go to the new users project page
    And I fill in "Project title" with "New Project"
    And I fill in "Company" with "Coca Cola"
    And I fill in "Skills used" with "Design"
    And I press "Create"
    Then I should see "Only 2 more to go"

  @javascript
  Scenario: A visitor should be able to view a project
    Given a user "me" exists with first_name: "Ilya"
    Given a project exists with title: "Cool project", company: "Coca Kola", creator: user "me"
    And I go to user "me"'s page
    And I follow "Cool project preview"

  @javascript
  Scenario: A visitor should not be able to see edit link for a project
    Given a user "me" exists with first_name: "Ilya"
    Given a project exists with title: "Cool project", company: "Coca Kola", creator: user "me"
    And I go to user "me"'s page
    And I follow "Cool project preview"
    Then I should not see "Edit"

  @javascript
  Scenario: I should be able to update tags
    Given a user "me" exists with email: "ilyakatz@gmail.com"
    When I login as "ilyakatz@gmail.com"
    And user "me" created project "Cool project"
    And I go to user "me"'s page
    And I follow "Cool project preview"
    Then I follow "Edit"
    And I fill in skill "graphic design"
    And I press "Update"
    When I go to the users dashboards page
    And I follow "Cool project preview"
    Then I should see "graphic design"

