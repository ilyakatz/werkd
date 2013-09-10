Feature: Administration

 Scenario: Admins should be able to see all users
  Given a user "admin@werked.net" exists
  When I login as "admin@werkd.net"
  When I go to the admin users page
  Then I should see "admin@werkd.net"
