Feature: Add and delete account API test
  @AddAndDeleteAccount_1
  Scenario Outline: Add and delete account with different user
    * def createAccount = callonce read('NewAccount.feature@NewAccount_2')
    * def newAccountId = createAccount.response.id
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

