Feature: API testing for security functions
  Background: Setup test
    Given url BASE_URL
    Given path '/api/token'
  @UserStory1
  Scenario: Valid token with valid credentials
    Given request
      """
      {
        "username": "supervisor",
        "password": "tek_supervisor"
      }
      """
    When method post
    Then status 200
    Then print response
    Then assert response.username == "supervisor"

  @UserStory2
  Scenario Outline: Valid token with invalid credentials
    Given request
      """
      {
        "username": "<username>",
        "password": "<password>"
      }
      """
    When method post
    Then status <statusCode>
    Then print response
    Then assert response.errorMessage == "<error>"
    Examples:
      | username   | password       | statusCode | error                  |
      | invalid    | tek_supervisor | 404        | User invalid not found |
      | supervisor | wrongpassword  | 400        | Password not matched   |