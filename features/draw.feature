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
    Then the output should contain "added Test"

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

  Scenario: Show a particular guest gift recipient
    Given I have the following guests:
    """
    Mr Brault,Mme Martineau
    Phil,Priss
    """
    When I run `draw show Phil`
    Then the output should contain "Phil"
