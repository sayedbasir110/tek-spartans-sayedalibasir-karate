Feature: Testing Account APIs

Background: Setup test
Given url BASE_URL
  * def generateTokenResult = callonce read('GenerateSupervisorToken.feature')
  Then print generateTokenResult
  * def validToken = "Bearer " + generateTokenResult.response.token
  Given path "/api/accounts/get-account"
  And header Authorization = validToken

  @Account_1
  Scenario: Testing /api/accounts/get-account
    * def accountId = 9479
    Given param primaryPersonId = accountId
    When method get
    Then status 200
    Then assert response.primaryPerson.id == accountId

  @Account_2
  Scenario: Testing get-account with non-existing accountId
  * def accountId = 55225522
      Given param primaryPersonId = accountId
      When method get
      Then status 404
      Then assert response.errorMessage == "Account with id "+accountId+" not found"