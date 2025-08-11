Feature: This feature file contains all test cases related to user registration

  Background: This file will include all test cases related to /register endpoint
    * def api = read('classpath:resources/api.json')
    * def helper = read('classpath:resources/helper.json')
    * def users = helper.user
    * url api.baseUrl
    * header x-api-key = 'reqres-free-v1'

  @positive
  Scenario: Register user with valid email and password
    Given path api.path.register
    * def email = users.eve
    * def password = "pistol"
    And request
    """
    {
      email: "#(email)",
      password: "#(password)"
    }
    """
    When method post
    Then status 200
    And match response ==
    """
    {
      id: '#number',
      token: '#string'
    }
    """

  @negative
  Scenario: Register user without password
    Given path api.path.register
    * def email = users.sydney
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
  Scenario: Register user without email
    Given path api.path.register
    * def password = "pistol"
    And request
    """
    {
      password: "#(password)"
    }
    """
    When method post
    Then status 400
    And match response.error == "Missing email or username"

  @negative
  Scenario: Register user with invalid email format
    Given path api.path.register
    * def email = "invalidemail.com"
    * def password = "pistol"
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
  Scenario: Register user with empty email and password
    Given path api.path.register
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
  Scenario: Register user with extra fields in request body
    Given path api.path.register
    * def email = users.eve
    * def password = "pistol"
    And request
    """
    {
      email: "#(email)",
      password: "#(password)",
      role: "admin"
    }
    """
    When method post
    Then status 200
    And match response.id == '#number'
    And match response.token == '#string'

  @functionality
  Scenario: Verify registration response time
    Given path api.path.register
    * def email = users.eve
    * def password = "pistol"
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
