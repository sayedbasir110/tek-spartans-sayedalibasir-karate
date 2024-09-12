Feature: Add car and phone API test
  @AddCarAndPhone_1
  Scenario: Add car and phone to account with valid token
    * def newAccount = callonce read('NewAccount.feature@NewAccount_2')
    * def newAccountId = newAccount.response.id

    Given url BASE_URL
    And path "/api/accounts/add-account-car"
    * def supervisor = callonce read('GenerateSupervisorToken.feature')
    And header Authorization = "Bearer " + supervisor.response.token
    And param primaryPersonId = newAccountId
    And request
      """
    {
    "make": "Toyota",
    "model": "Highlander",
    "year": "2023",
    "licensePlate": "V3R56E"
    }
    """
    When method post
    Then status 201
    And print response

    Given path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer " + supervisor.response.token
    And param primaryPersonId = newAccountId
    And request
      """
    {
    "phoneNumber": "2365982522",
    "phoneExtension": "N/A",
    "phoneTime": "DayTime",
    "phoneType": "Mobile"
    }
      """
    When method post
    Then status 201
    And print response

