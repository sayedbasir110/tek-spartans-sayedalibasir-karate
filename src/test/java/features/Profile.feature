Feature: Testing profile APIs
  @Profile_1
  Scenario Outline: Testing /api/user/profile with supervisor and operator credentials
    Given url BASE_URL
    And path "/api/token"
    And request
      """
      {
        "username": "<userName>",
        "password": "<password>"
      }
      """
    And method post
    Then status 200
    * def token = response.token
    Given path "/api/user/profile"
    And header Authorization = "Bearer " + token
    When method get
    Then status 200
    And print response
    And assert response.accountType == "<accountType>"
    Examples:
      | userName          | password       | accountType |
      | supervisor        | tek_supervisor | CSR         |
      | operator_readonly | Tek4u2024      | CSR         |
      | johndoe           | John@123       | CUSTOMER    |



