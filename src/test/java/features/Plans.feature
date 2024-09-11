Feature: Testing Plan code
  @PlanCode_1
  Scenario: Testing endpoint /api/plans/get-all-pla-code
    Given url BASE_URL
    And path "/api/token"
    And request
      """
      {
        "username": "supervisor",
        "password": "tek_supervisor"
      }
      """
    When method post
    Then print response
    And status 200
    * def token = response.token
    Given path "/api/plans/get-all-plan-code"
    And header Authorization = "Bearer " + token
    When method get
    Then print response
    And status 200
    And assert response[0].planExpired == false
    And assert response[1].planExpired == false
    And assert response[2].planExpired == false
    And assert response[3].planExpired == false
    And assert response[0].createdBy == "SYSTEM"
    And assert response[1].createdBy == "SYSTEM"
    And assert response[2].createdBy == "SYSTEM"
    And assert response[3].createdBy == "SYSTEM"



