Feature: Creating new account API test
  @NewAccount_1
  Scenario: Testing /api/accounts/add-primary-account
    Given url BASE_URL
    And path "/api/accounts/add-primary-account"
    And request
    """
    {
      "email": "johndoe@email.com",
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
    And assert response.email == "johndoe@email.com"