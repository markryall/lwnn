Feature: adding simple literals to the execution stack

  In order to have something to pass to functions
  As I programmer
  I want to push literals onto the execution stack

  Scenario Outline:
    When I run `lwnn` interactively
    And I type "<Input>"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
    State: <State>
    """

  Examples:

  | Input    | State |
  | 2        | 2     |
  | 1 2      | 1 2   |
  | a        | a     |
  | true     | true  |
  | 1 2 +    | 1 2 + |
