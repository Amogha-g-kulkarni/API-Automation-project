Feature: This feature file contains all test cases related to /user endpoint

  Background: This file will include all test cases related to /user endpoint
    * def api = read('classpath:resources/api.json')
    * url api.baseUrl
    * header x-api-key = 'reqres-free-v1'

  @positive
  Scenario: Create user with valid data
    * def result = call read('classpath:resources/stringGenerator.feature@stringGenerator') { length: 8 }
    * def username = result.randomString
    Given path api.path.user
    And request
    """
    {
      name: "#(username)",
      job: "leader"
    }
    """
    When method post
    Then status 201
    And match response ==
    """
    {
      name: "#(username)",
      job: "leader",
      id: "#string",
      createdAt: "#string"
    }
    """

  @negative
  Scenario: Create user without job field
    * def result = call read('classpath:resources/stringGenerator.feature@stringGenerator') { length: 6 }
    * def username = result.randomString
    Given path api.path.user
    And request
    """
    {
      name: "#(username)"
    }
    """
    When method post
    Then status 201
    And match response.name == username

  @edge
  Scenario: Create user with long name
    * def longName = 'A'.repeat(300)
    Given path api.path.user
    And request
    """
    {
      name: "#(longName)",
      job: "tester"
    }
    """
    When method post
    Then status 201
    And match response.name == longName

  @positive
  Scenario: Update user details
    Given path api.path.user
    And path 2
    And request
    """
    {
      name: "Amogha",
      job: "leader"
    }
    """
    When method put
    Then status 200
    And match response.name == "Amogha"
    And match response.job == "leader"
    And match response.updatedAt == '#string'

  @negative
  Scenario: Update non-existent user
    Given path api.path.user
    And path 9999
    And request
    """
    {
      name: "GhostUser",
      job: "leader"
    }
    """
    When method put
    Then status 200
    And match response.name == "GhostUser"
    ## Reqres returns 200 even if user doesn't exist, but in real APIs this might be 404

  @positive
  Scenario: Delete existing user
    Given path api.path.user
    And path 2
    When method delete
    Then status 204

  @negative
  Scenario: Delete non-existent user
    Given path api.path.user
    And path 9999
    When method delete
    Then status 204
    ## Reqres returns 204 for any delete; in real APIs you'd expect 404

  @functionality
  Scenario: Verify response time for creating a user
    * def result = call read('classpath:resources/stringGenerator.feature@stringGenerator') { length: 5 }
    * def username = result.randomString
    Given path api.path.user
    And request
    """
    {
      name: "#(username)",
      job: "leader"
    }
    """
    When method post
    Then status 201
    And assert karate.responseTime < 2000
