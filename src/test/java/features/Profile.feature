Feature: Testing profile APIs
  @Profile_1
  Scenario Outline: Testing /api/user/profile with supervisor and operator credentials
    Given url BASE_URL
    And path "/api/user/profile"
    * def supervisor = callonce read('GenerateSupervisorToken.feature')
    * def operator = callonce read('GenerateOperatorToken.feature')
    And header Authorization = "Bearer " + <user>.response.token
    When method get
    Then status 200
    And print response
    And assert response.username == "<username>"
    Examples:
      | user       | username          |
      | supervisor | SUPERVISOR        |
      | operator   | operator_readonly |


