Feature: Create new account using java to generate random email
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