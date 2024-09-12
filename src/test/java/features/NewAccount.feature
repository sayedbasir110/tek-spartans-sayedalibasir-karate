Feature: Creating new account API test
  @NewAccount_1
  Scenario: Testing /api/accounts/add-primary-account
    Given url BASE_URL
    And path "/api/accounts/add-primary-account"
    And def email = "johndoe123@hotmail.com"
    And request
    """
    {
      "email": "#(email)",
      "firstName": "JOHN",
      "lastName": "DOE",
      "title": "Mr.",
      "gender": "Male",
      "maritalStatus": "Single",
      "employmentStatus": "Test Engineer",
      "dateOfBirth": "1996-01-01"
    }
    """
    When method post
    Then status 201
    And print response
    And assert response.email == email
    # delete the created account
    * def createdAccountId = response.id
    * def tokenGenerationResult = callonce read('GenerateSupervisorToken.feature')
    * def validToken = "Bearer " + tokenGenerationResult.response.token
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = createdAccountId
    And header Authorization = validToken
    When method delete
    Then status 202

  @NewAccount_2
  Scenario: Testing /api/accounts/add-primary-account with random email from java
    Given url BASE_URL
    And path "/api/accounts/add-primary-account"
    And def email = Java.type('data.RandomEmail').generateRandomEmail()
    And request
      """
      {
        "email": "#(email)",
        "firstName": "JOHN",
        "lastName": "DOE",
        "title": "Mr.",
        "gender": "Male",
        "maritalStatus": "Single",
        "employmentStatus": "Test Engineer",
        "dateOfBirth": "1996-01-01"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == email