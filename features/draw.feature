Feature: My bootstrapped app kinda works
  In order to get going on coding my awesome app
  I want to have aruba and cucumber setup
  So I don't have to do it myself

  Scenario: App just runs
    When I get help for "draw"
    Then the exit status should be 0

  Scenario: Show all guests
    When I run `draw list`
    Then GUESTS.length should == 2

  @wip
  Scenario: List a particular guest
    # Given I have the following guests:
    # """
    # {name: Mr Brault, joint: Mme Brault}
    # {name: Phil, joint: Priss}
    # """
    When I run `draw list Phil`
    Then the output should contain "Phil"
    And the output should contain "Priss"

  Scenario: Show a particular guest gift recipient
    # Given I have the following guests:
    # """
    # {name: Mr Brault, joint: Mme Brault}
    # {name: Phil, joint: Priss}
    # """
    When I run `draw show Phil`
    Then the output should contain "Phil"

  Scenario: Add a guest to the list of guests
    When I run `draw add Test`
    Then the output should contain "added Test"

  Scenario: Export guest list into file
  When I run `draw export`
  Then a file named "guests.txt" should exist
  And the file "guests.txt" should contain:
    """
    ["{name: Mr Brault, joint: Mme Brault}", "{name: Phil, joint: Priss}"]
    """