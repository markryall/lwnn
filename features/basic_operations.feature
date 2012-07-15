Feature: evaluation some simple operations

  In order to perform calculations
  As I programmer
  I want to execute basic arithmetic functions on the stack

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
  | 1 2 +         | 3     |
  | 1 2 -         | 1     |
  | 2 3 *         | 6     |
  | 2 4 /         | 2     |
  | 2 3 + . 3 +   | 8     |
  | 1 2 - 5 +     | 6     |
  | 1 dup         | 1 1   |
  | 1 2 swap      | 2 1   |
  | 1 2 >         | true  |
  | 1 2 <         | false |
  | 1 2 =         | false |
