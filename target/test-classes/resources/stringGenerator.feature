@stringGenerator
Feature: String Generator Helper Functions

Background:
  * def charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'

Scenario: Generate random string
  * def generateRandomString =
  """
  function(length) {
    var result = '';
    for (var i = 0; i < length; i++) {
      result += charset.charAt(Math.floor(Math.random() * charset.length));
    }
    return result;
  }
  """
  * def randomString = generateRandomString(length || 10)
  * def result = { randomString: randomString }
