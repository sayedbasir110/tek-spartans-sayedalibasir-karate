Feature: Add and delete account API test

  @AddAndDeleteAccount
  Scenario: Add retrieve and delete an account test
    Given url BASE_URL
    * def newAccount = callonce read('NewAccount.feature@NewAccount_2')
    * def newAccountId = newAccount.response.id

    Given path "/api/accounts/get-account"
    * def supervisor = callonce read('GenerateSupervisorToken.feature')
    * def token = supervisor.response.token
    Given header Authorization = "Bearer " + token
    And param primaryPersonId = newAccountId
    And method get
    Then status 200
    And print response
    And assert response.primaryPerson.email == newAccount.response.email
    And assert response.primaryPerson.firstName == newAccount.response.firstName
    And assert response.primaryPerson.gender == newAccount.response.gender

    Given path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = newAccountId
    And method delete
    Then status 202

    Given path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + token
    And param primaryPersonId = newAccountId
    And method delete
    Then status 404
