Feature: My bootstrapped app kinda works
  In order to get going on coding my awesome app
  I want to have aruba and cucumber setup
  So I don't have to do it myself

  Scenario: App just runs
    When I get help for "draw"
    Then the exit status should be 0

  @wip
  Scenario: Add a guest to the list of guests
    When I run `draw guests add -n Test -j NoOne`
    Then the output should contain "Successfully added guest Test"

  @wip
  Scenario: Add a guest without joint to the list of guests
    When I run `draw guests add -n Test`
    Then the output should contain "Successfully added guest Test"

  @wip
  Scenario: Add a guest with no name to the list of guests
    When I run `draw guests add -j NoOne`
    Then the output should contain "error: n is required"

  @wip
  Scenario: Show all guests
    Given I have the following guests:
    """
    Mr Brault,Mrs Brault
    Mr Martineau,Mrs Martineau
    """
    When I run `draw guests list`
    Then the output should contain "Mr Brault"
    And the output should contain "Mrs Martineau"

  @wip
  Scenario: List a particular guest
    Given I have the following guests:
    """
    Mr Brault,Mrs Brault
    Mr Martineau,Mrs Martineau
    """
    When I run `draw guests list brau`
    Then the output should contain "Mr Brault"
    And the output should contain "Mrs Brault"

  @wip
  Scenario: Clear the guest list
    Given I have the following guests:
    """
    Mr Brault,Mrs Martineau
    Phil,Priss
    """
    When I run `draw guests clear`
    Then the output should contain "Successfully deleted all guests"

  @wip
  Scenario: Match the guest list couples
    Given I have the following guests:
    """
    Mr Brault,Mrs Martineau
    Phil,Priss
    """
    When I run `draw guests match`
    Then the output should contain "Successfully matched all guests"

  @wip
  Scenario: Clear the draw list
    Given I have the following gifts:
    """
    Mr Brault,Mrs Leon
    Phil,Mrs Leon
    Mr Leon,Mrs Brault
    """
    When I run `draw clear`
    Then the output should contain "Successfully deleted draw list of gifts"

  @wip
  Scenario: Run the draw on single guest list
    Given I have the following guests:
    """
    Mr Brault,Mrs Martineau
    """
    When I run `draw run`
    Then the output should contain "Draw can only run with 2 or more guests"
    And the output should contain "Failed"

  @wip
  Scenario: Run the draw on current guests list
    Given I have the following guests:
    """
    Mr Brault,Mrs Martineau
    Phil,Priss
    Mr Leon,Mrs Leon
    Mickey,Minnie
    """
    When I run `draw run`
    Then the output should contain "Success"


