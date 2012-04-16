Feature: adding simple literals to the execution stack

  In order to have something to pass to functions
  As I programmer
  I want to push literals onto the execution stack

  Scenario:
    When I run `lwnn` interactively
    And I type "2"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
    Stack: 2
    """

  @wip
  Scenario:
    When I run `lwnn` interactively
    And I type "'a'"
    And I type "exit"
    Then the exit status should be 0
    And the stdout should contain:
    """
    Stack: 'a'
    """
