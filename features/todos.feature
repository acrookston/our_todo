Feature: view pages
  Scenario: View todos
    Given the following todos exist:
      | Title       | Published at     | Completed |
      | Eat lunch   | 2011-08-26 14:13 | false     |
      | Brush teeth | 2011-08-25 14:41 | true      |
    And I am on the home page
    Then I should see "Eat lunch"
    And I should see "Brush teeth"
  Scenario: Add a todo
    Given I am on the home page
    And I fill in "title" with "Add cucumber tests"
    When I press "Add Task"
    Then I should be on the home page
    And I should see "Add cucumber tests"

# Todo test sort order and updates