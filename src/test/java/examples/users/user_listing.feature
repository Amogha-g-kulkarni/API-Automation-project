Feature: This feature file contains all test cases related to retrieving users

  Background: This file will include all test cases related to /user endpoint
    * def api = read('classpath:resources/api.json')
    * url api.baseUrl
    * header x-api-key = 'reqres-free-v1'

  @positive
  Scenario: Get user details page wise
    Given path api.path.user
    And param page = 2
    When method get
    Then status 200
    And match response.page == 2
    And match response.per_page == 6
    And match response.total == '#number'
    And match response.total_pages == '#number'
    * def userArray = response.data
    * match each userArray ==
    """
    {
      id: '#number',
      email: '#string',
      first_name: '#string',
      last_name: '#string',
      avatar: '#string'
    }
    """

  @positive
  Scenario: Get details of single user
    Given path api.path.user
    And path 2
    When method get
    Then status 200
    And match response.data ==
    """
    {
      id: 2,
      email: '#string',
      first_name: '#string',
      last_name: '#string',
      avatar: '#string'
    }
    """

  @negative
  Scenario: Get details of non-existent user
    Given path api.path.user
    And path 333
    When method get
    Then status 404

  @edge
  Scenario: Get users with page number exceeding total pages
    Given path api.path.user
    And param page = 999
    When method get
    Then status 200
    And match response.data == []

  @edge
  Scenario: Get users with invalid page parameter
    Given path api.path.user
    And param page = -1
    When method get
    Then status 200
    And match response.page == -1

  @functionality
  Scenario: Delayed response
    Given path api.path.user
    And param delay = 3
    When method get
    Then status 200
    And assert karate.responseTime >= 3000

  @functionality
  Scenario: Verify response time for normal request
    Given path api.path.user
    And param page = 1
    When method get
    Then status 200
    And assert karate.responseTime < 2000
