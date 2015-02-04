@wip
Feature: Injecting services into contexts
  In order to make the maintenance of my contexts easier
  I need to delegate creation of context dependencies
  As a Behat User

  Background:
    Given the extension's argument resolver is enabled

  Scenario: Service class name matches the argument's type hint
    Given the following "features/bootstrap/config/services.yml" file is imported in behat.yml:
    """
    services:
      acme_foo:
        class: Acme\Foo
        tags:
          - { name: no.context.argument }
    """
    And the "Acme\Foo" is an existing class
    When I type hint a context's constructor argument with "Acme\Foo"
    Then the "acme_foo" service should be automatically injected into the context's constructor

  Scenario: Service class name extends the type hinted class
    Given the following "features/bootstrap/config/services.yml" file is imported in behat.yml:
    """
    services:
      acme_foo:
        class: Acme\Foo
        tags:
          - { name: no.context.argument }
    """
    And the "Acme\Foo" class extends the "Acme\Bar" class
    When I type hint a context's constructor argument with "Acme\Bar"
    Then the "acme_foo" service should be automatically injected into the context's constructor

  Scenario: Service class name implements the type hinted interface
    Given the following "features/bootstrap/config/services.yml" file is imported in behat.yml:
    """
    services:
      acme_foo:
        class: Acme\Foo
        tags:
          - { name: no.context.argument }
    """
    And the "Acme\Foo" class implements the "Acme\Bar" interface
    When I type hint a context's constructor argument with "Acme\Bar"
    Then the "acme_foo" service should be automatically injected into the context's constructor

  Scenario: Service id is configured on the context's argument list
    Given the following "features/bootstrap/config/services.yml" file is imported in behat.yml:
    """
    services:
      acme_foo:
        class: Acme\Foo
    """
    And the "Acme\Foo" is an existing class
    And the context is configured to accept an argument:
    """
    default:
      suites:
        acme:
          contexts:
            - FeatureContext:
                foo: @acme_foo
    """
    Then the "acme_foo" service should be automatically injected into the context's constructor
