This repository shows how we can practice Acceptance Test-Driven Development to develop Shiny apps.

- [Start with a vague wish.](#start-with-a-vague-wish)
- [Turn the wish into User Stories.](#turn-the-wish-into-user-stories)
- [Create examples for each User Story.](#create-examples-for-each-user-story)
- [Turn scenarios into executable specifications and working software.](#turn-scenarios-into-executable-specifications-and-working-software)

## Start with a vague wish.

Every software project starts with some wish we want to fulfill.

At the beginning it's usually vague, like:

"I wish I could manage my personal finances better."

After we capture the wish, we can start breaking it down into smaller pieces and think about what it actually means.

## Turn the wish into User Stories.

- "As a user, I want to see my total income and expenses so that I can understand my current financial situation."
- "As a user, I want to categorize my expenses so that I can identify areas where I can save money."
- "As a user, I want to set a monthly budget and track how much I have spent against it."

## Create examples for each User Story.

Once we are ready with our User Stories, we can start creating examples that will fullfil the User Stories.

**⚠️ A few antipatterns to avoid:**
- **Confusing UI and behaviour.** Don't write specifications with keywords like "click", "type", "select", "field", etc. If we don't speficy the UI, we can change it without changing the tests. It also allows us to innovate as we don't prescribe how the UI should look.
- **Making scenarios too long.** Keep them short and focused on one outcome whenever possible.
- **No reuse of steps.** How can there be a system with no common steps to different things? Think about how you phrase your steps and reuse them in different scenarios.
- **Too many scenarios.** Don't use only scenarios as automated tests, use them to cover behaviour of users, not every possible edge case.

**Example of a scenario for User Story 1.**

```gherkin
Given I have recorded my income of $2000
And I have recorded my expenses of $500
When I view my dashboard
Then I should see my total income as $2000
And my total expenses as $500
And my net balance as $1500
```

**Example of a scenario for User Story 2.**

```gherkin
Given I have recorded an expense of $50 for "Groceries"
And an expense of $100 for "Entertainment"
When I view my categorized expenses
Then I should see "Groceries" total as $50
And "Entertainment" total as $100
```

## Turn scenarios into executable specifications and working software.

You can see the implementation of tests and the app, but I recommend you go through the commits to see how the app was developed step by step.

<!-- START_COMMITS -->
### 1. **[test: :test_tube::x: Outline the first scenario and make it fail.](https://github.com/jakubsob/shiny-acceptance-tdd/commit/f4fc7b34abfe323ba970ba962ab6429a85f4a959)**
- Create `tests/acceptance/` directory for acceptance tests.
- Create `.test_acceptance()` command to conveniently run acceptance tests.
- Create acceptance test stage on CI.
- Create a test file in `tests/acceptance/`.
- Create the first test case, put the scenario name in `test_that()`.
- Call functions that will become our domain specific language. The don't exist yet, create an interface that will be easy to read and feed needed parameters.
- Implement domain specific language in a separate file, force verify functions to fail, so that we know our software is not working yet.
- Verify that acceptance tests fail :x:.

### 2. **[test: :test_tube::x: Add Shiny app protocol driver and the first scenario step implementation](https://github.com/jakubsob/shiny-acceptance-tdd/commit/f5232966e17835e1d5998c935964fbc5fb6da548)**
- Create a wrapper for `shinytest::AppDriver` to allow adding our own methods of interacting with the System Under Test (SUT).
- Add a method for interacting with the SUT. It's purpose is to hide the implementation details of how we interact with the SUT. If we ever want to interact with the SUT in another way, we would implement another driver with a method with the same name and interface.
- Call the driver method from the DSL function.
- Tests should fail due to a timeout, tests want to interact with an element that doesn't exist yet :x:.

### 3. **[feat: :test_tube::x: Implement the input needed by `record_income()` step](https://github.com/jakubsob/shiny-acceptance-tdd/commit/1e5e58d0f9fc999feef2cb8a84022876acbdcc9e)**
- Implement the numeric input needed by the first scenario step.
- Run tests to validate that tests pass successfully through `record_income()` step.
- Tests should be still failing due to forced fail in verify function :x:.

### 4. **[test: :test_tube::x: Implement `record_expense()` step](https://github.com/jakubsob/shiny-acceptance-tdd/commit/a64ab2a5b1b3490d7c826941dd95af624fed3149)**
- Implement `record_expense()` step.
- Run tests to check that tests fail at this step :x:.

### 5. **[feat: :test_tube::x: Implement input needed by `record_expense()` step](https://github.com/jakubsob/shiny-acceptance-tdd/commit/8f6ad28719f226d5e5a97d9e4651e333327c6c71)**
- Implement the numeric input needed by `record_expense()` step.
- Run tests to validate that tests pass successfully through `record_expense()` step.
- Tests should be still failing due to forced fail in verify function :x:.

### 6. **[refactor: :recycle::x: Add buttons to confirm the income and expense input](https://github.com/jakubsob/shiny-acceptance-tdd/commit/6530b7edb2e7dd28065340b76c62187cb7fcf04a)**
- Don't change the DSL, clicking the buttons is a part of `record_income` and `record_expense` actions. This is why not mentioning UI in the DSL matters, as it allows us to refactor the UI without changing the tests.
- Modify the `record_income` and `record_expense` actions to include the button clicks.
- Implement the buttons in production code.
- Tests should be still failing due to forced fail in verify function ❌.

### 7. **[test: :test_tube::x: Implement `verify_total_income()` step](https://github.com/jakubsob/shiny-acceptance-tdd/commit/66b2c6d34c0af0a18ea39e34d277a6425756ca58)**
- We expect that there will be an element from which we extract the numeric value.
- Tests should be still failing, now due a timeout. Total income element is not yet implemented :x:.

### 8. **[feat: :test_tube::x: Implement verifying total income](https://github.com/jakubsob/shiny-acceptance-tdd/commit/d9a976a793a25e00553336e330c6915f674999a0)**
- Implement the business logic of calculating the total based on given income and expenses.
- `verify_total_income()` should pass, other assertions should fail :x:.

### 9. **[test: :test_tube::x: Implement `verify_total_expenses()` step](https://github.com/jakubsob/shiny-acceptance-tdd/commit/8c548c73ab6ce50638b5ddcfcb645a3f940d63aa)**

### 10. **[feat: :test_tube::x: Implement verifying total expenses](https://github.com/jakubsob/shiny-acceptance-tdd/commit/3268783e1d9f48ea9e175d45213ebad7915815ea)**
- Add business logic for calculating total expenses.
- Tests should pass `verify_total_expenses()` step. `verify_net_balance()` should fail :x:.

### 11. **[test: :test_tube::x: Implement `verify_net_balance()` step](https://github.com/jakubsob/shiny-acceptance-tdd/commit/73257e6731a6bcde73144e1ab0360d6e2d8f0081)**

### 12. **[feat: :test_tube::white_check_mark: implement verifying net balance](https://github.com/jakubsob/shiny-acceptance-tdd/commit/fe20649460254a020da0c068553e47ea34f6ad22)**
- Add business logic to verify net balance.
- All assertions should pass :white_check_mark:.

### 13. **[refactor: :recycle::white_check_mark: Refactor inputs to a components module](https://github.com/jakubsob/shiny-acceptance-tdd/commit/c4a0b87568410a1221f5c5606c6263c09c85e988)**
- We can safely refactor the code, we will know if code still works as long as tests are passing.

### 14. **[test: :test_tube::white_check_mark: Add a second scenario](https://github.com/jakubsob/shiny-acceptance-tdd/commit/380f575eb64a880e3876fb9c7084a0c2fbc87af3)**
- Add a second test scenario to test if we can record multiple expenses.
- Reuse existing steps to create a new scenario.
- Implement a teardown function to allow running multiple scenarios.

### 15. **[test: :test_tube::x: Create specification for the registry – interface for persistent storage](https://github.com/jakubsob/shiny-acceptance-tdd/commit/6e79158f28c7a125497fbba0c66890bb853ed4e0)**
- Add unit tests for an object that the app will interact with to store data to a persistent storage.
- I want to use a `registry` object to run operations on a `storage` object. The storage will be a CSV file, but it could as well be a database connection or a S3 bucket.
- This is an implementation detail of the app, it doesn't change the behavior of the app – tests are added to `tests/testthat/`, no changes in acceptance tests are needed.

### 16. **[test: :test_tube::x: Add specification for CSV storage](https://github.com/jakubsob/shiny-acceptance-tdd/commit/d3adea51e9524ee89e459b56820bf4831d23e05b)**
- Create a specification for an interface that will connect the app with a CSV file.

### 17. **[feat: :test_tube::white_check_mark: Add implementation of the storage and registry](https://github.com/jakubsob/shiny-acceptance-tdd/commit/792e8558da481ab51815340c7c8a4dbf2a8a3067)**
- Create an implementation objects perviously specified in tests.
- Leave the doors open for other implementations of interfaces so that we could extend the implementation to use a database or a S3 bucket.
- The new code is not used in the app code yet. We will do that in the next commits.

### 18. **[feat: :test_tube::white_check_mark: Integrate storage code with the app](https://github.com/jakubsob/shiny-acceptance-tdd/commit/3f7e4457cc06bba5c938de28be980519de56a63a)**
- Use new interface of saving inputs in the app.
- Update the acceptance test so that each test case uses it's own storage, making them independent of each other.

### 19. **[refactor: :recycle::white_check_mark: Refactor the interface of the app](https://github.com/jakubsob/shiny-acceptance-tdd/commit/ecbccab312c3c106ab2ec9e26a0bb8e0c21b95a8)**
- With the Users' needs satisfied (acceptance tests are passing), we can work on improving the style of the app.
- We can move and style elements on the page any way we want.
- As long as we don't change `data-test` attributes or types of elements, acceptance tests will pass.
- If we change the type of component, e.g. numeric input to a dropdown, we only need to change the implementation of interaction with this component.


<!-- END_COMMITS -->
