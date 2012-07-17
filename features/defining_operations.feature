Feature: define new operations

  In order to perform calculations
  As I programmer
  I want to define new operations

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

  | Input                       | State |
  | 1 + e let . 2 e .           | 3     |
  | f + e let . 3 f let . f e . | 6     |
