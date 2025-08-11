Feature: This feature file contains all test cases related to user login

  Background: This file will include all test cases related to /login end point
    * def api = read('classpath:resources/api.json')
    * def helper = read('classpath:resources/helper.json')
    * def users = helper.user
    * url api.baseUrl
    * header x-api-key = 'reqres-free-v1'

  @positive
  Scenario: Login using valid email and password
    Given path api.path.login
    * def email = users.eve
    * def password = "cityslicka"
    And request 
    """
    {
      email: "#(email)",
      password: "#(password)"
    }
    """
    When method post
    Then status 200
    And match response.token == '#string'
    And match response.token != ''

  @negative
  Scenario: Login fail because of missing password field
    Given path api.path.login
    * def email = users.eve
    And request 
    """
    {
      email: "#(email)"
    }
    """
    When method post
    Then status 400
    And match response.error == "Missing password"

  @negative
  Scenario: User not found case
    Given path api.path.login
    * def email = users.sydney
    * def password = "cityslicka"
    And request 
    """
    {
      email: "#(email)",
      password: "#(password)"
    }
    """
    When method post
    Then status 400
    And match response.error == "user not found"

  @negative
  Scenario: Login with incorrect password
    Given path api.path.login
    * def email = users.eve
    * def password = "wrongpassword"
    And request 
    """
    {
      email: "#(email)",
      password: "#(password)"
    }
    """
    When method post
    Then status 400
    And match response.error == '#string'

  @negative
  Scenario: Login with invalid email format
    Given path api.path.login
    * def email = "invalidemail.com"
    * def password = "cityslicka"
    And request 
    """
    {
      email: "#(email)",
      password: "#(password)"
    }
    """
    When method post
    Then status 400
    And match response.error == '#string'

  @edge
  Scenario: Login with empty email and password
    Given path api.path.login
    * def email = ""
    * def password = ""
    And request 
    """
    {
      email: "#(email)",
      password: "#(password)"
    }
    """
    When method post
    Then status 400
    And match response.error == '#string'

  @edge
  Scenario: Login with extra fields in request body
    Given path api.path.login
    * def email = users.eve
    * def password = "cityslicka"
    And request 
    """
    {
      email: "#(email)",
      password: "#(password)",
      extraField: "unexpected"
    }
    """
    When method post
    Then status 200
    And match response.token == '#string'

  @functionality
  Scenario: Verify response time for login
    Given path api.path.login
    * def email = users.eve
    * def password = "cityslicka"
    And request 
    """
    {
      email: "#(email)",
      password: "#(password)"
    }
    """
    When method post
    Then status 200
    And assert karate.responseTime < 2000
