Feature: Get accounts API testing
  Background: Setup test
    Given url BASE_URL
    And path "/api/accounts/get-all-accounts"

  @GetAccounts_1
  Scenario: Testing /api/accounts/get-all-accounts without authentication
      When method get
      Then status 401

  @GetAccounts_2
  Scenario: Testing /api/accounts/get-all-accounts with valid authentication
    * def generateTokenResult = callonce read('GenerateSupervisorToken.feature')
    * def validToken = "Bearer " + generateTokenResult.response.token
    Given header Authorization = validToken
    When method get
    Then status 200


