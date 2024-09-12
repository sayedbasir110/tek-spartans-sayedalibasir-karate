Feature: Testing profile APIs
  @Profile_1
  Scenario Outline: Testing /api/user/profile with supervisor and operator credentials
    Given url BASE_URL
    And path "/api/user/profile"
    * def supervisorToken = callonce read('GenerateSupervisorToken.feature')
    * def operatorToken = callonce read('GenerateOperatorToken.feature')
    And header Authorization = "Bearer " + <userToken>.response.token
    When method get
    Then status 200
    And print response
    And assert response.username == "<username>"
    Examples:
      | userToken       | username   |
      | supervisorToken | SUPERVISOR |
      | operatorToken   | operator_readonly   |


