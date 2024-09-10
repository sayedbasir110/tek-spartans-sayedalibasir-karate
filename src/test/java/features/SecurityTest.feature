Feature: API testing for security functions
  Background: Setup test
    Given url 'https://dev.insurance-api.tekschool-students.com'
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
    Examples:
      | username   | password       | statusCode |
      | invalid    | tek_supervisor | 404        |
      | supervisor | wrongpassword  | 400        |