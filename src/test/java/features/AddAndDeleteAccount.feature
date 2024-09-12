Feature: Add and delete account API test
  @AddAndDeleteAccount_1
  Scenario Outline: Add and delete account with different user
    Given url BASE_URL
    And path "/api/accounts/add-primary-account"
    * def email = Java.type('data.RandomEmail').generateRandomEmail()
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
    And assert response.firstName == "JOHN"
    * def newAccountId = response.id
    Given url BASE_URL
    And path "/api/token"
    And request
      """
      {
        "username": "<userName>",
        "password": "<password>"
      }
      """
    When method post
    Then status 200
    * def token = response.token
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = newAccountId
    And header Authorization = "Bearer " + token
    When method delete
    Then status <statusCode>
    Examples:
      | userName          | password       | statusCode |
      | operator_readonly | Tek4u2024      | 403        |
      | supervisor        | tek_supervisor | 202        |

