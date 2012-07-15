Feature: evaluation some simple conditionals

  In order to perform branching logic
  As I programmer
  I want conditional logic evaluation to be available

  Scenario Outline:
    When I run `lwnn` interactively
    And I type "<Input> ."
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
    State: <State>
    """

  Examples:

  | Input         | State |
  | 1 2 true if   | 2     |
  | 1 2 false if  | 1     |