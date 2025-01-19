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
### 1. **[test: :test_tube::x: Outline the first scenario and make it fail.](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/f4fc7b34abfe323ba970ba962ab6429a85f4a959)**
- Create `tests/acceptance/` directory for acceptance tests.
- Create `.test_acceptance()` command to conveniently run acceptance tests.
- Create acceptance test stage on CI.
- Create a test file in `tests/acceptance/`.
- Create the first test case, put the scenario name in `test_that()`.
- Call functions that will become our domain specific language. The don't exist yet, create an interface that will be easy to read and feed needed parameters.
- Implement domain specific language in a separate file, force verify functions to fail, so that we know our software is not working yet.
- Verify that acceptance tests fail :x:.

### 2. **[test: :test_tube::x: Add Shiny app protocol driver and the first scenario step implementation](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/d7566de0778861ef83fa8c70db7bdd0acfc09878)**
- Create a wrapper for `shinytest::AppDriver` to allow adding our own methods of interacting with the SUT.
- Add a method for interacting with the SUT. It's purpose is to hide the implementation details of how we interact with the SUT. If we ever want to interact with the SUT in another way, we would implement another driver with a method with the same name and interface.
- Call the driver method from the DSL function.
- Tests should fail due to a timeout, tests want to interact with an element that doesn't exist yet :x:.

### 3. **[feat: :test_tube:::x: Implement the input needed by `record_income()` step](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/9ec150c0e2f551286d72afc6c4f1135ee53982e2)**
- Implement the numeric input needed by the first scenario step.
- Run tests to validate that tests pass successfully through `record_income()` step.
- Tests should be still failing due to forced fail in verify function :x:.

### 4. **[test: :test_tube::x: Implement `record_expense()` step](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/0725a3c4dfccf6c534c0aa0ebb098747afb95e56)**
- Implement `record_expense()` step.
- Run tests to check that tests fail at this step :x:.

### 5. **[feat: :test_tube::x: Implement input needed by `record_expense()` step](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/79f183d346a74888e5e371d776370b928d3daa2d)**
- Implement the numeric input needed by `record_expense()` step.
- Run tests to validate that tests pass successfully through `record_expense()` step.
- Tests should be still failing due to forced fail in verify function :x:.

### 6. **[refactor: :recycle::x: Add buttons to confirm the income and expense input](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/7a47469c0f511081be0df5679324008d4b8b5144)**
- Don't change the DSL, clicking the buttons is a part of `record_income` and `record_expense` actions. This is why not mentioning UI in the DSL matters, as it allows us to refactor the UI without changing the tests.
- Modify the `record_income` and `record_expense` actions to include the button clicks.
- Implement the buttons in production code.
- Tests should be still failing due to forced fail in verify function ❌.

### 7. **[test: :test_tube::x: Implement `verify_total_income()` step](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/6b6e7b5a604a09858b98e36999efe3d4de6b0637)**
- We expect that there will be an element from which we extract the numeric value.
- Tests should be still failing, now due a timeout. Total income element is not yet implemented :x:.

### 8. **[feat: :test_tube::x: Implement verifying total income](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/4ea96ba94b53e16da855e429ce82c1acc8f2dd1f)**
- Implement the business logic of calculating the total based on given income and expenses.
- `verify_total_income()` should pass, other assertions should fail :x:.

### 9. **[test: :test_tube::x: Implement `verify_total_expenses()` step](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/923cd9ceac0f7eeb51eaaa5e1324c4babb5e31e5)**

### 10. **[feat: :test_tube::x: Implement verifying total expenses](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/30ea44b488d3dd61f5a7be936fe6ee36483e371e)**
- Add business logic for calculating total expenses.
- Tests should pass `verify_total_expenses()` step. `verify_net_balance()` should fail :x:.

### 11. **[test: :test_tube::x: Implement `verify_net_balance()` step](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/7f643b9ae7fe32c1cf94126742762cbb1568e733)**

### 12. **[feat: :test_tube::white_check_mark: implement verifying net balance](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/c51f3492349047ef962306d57895c167819fca8b)**
- Add business logic to verify net balance.
- All assertions should pass :white_check_mark:.

### 13. **[refactor: :recycle::white_check_mark: Refactor inputs to a components module](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/c0f4df2f31b3f4965d80c4a391931e6f32c6c7f7)**
- We can safely refactor the code, we will know if code still works as long as tests are passing.

### 14. **[test: :test_tube::white_check_mark: Add a second scenario](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/adae8cd3e901a81c8e3048ea42fafb7e6d0df130)**
- Add a second test scenario to test if we can record multiple expenses.
- Reuse existing steps to create a new scenario.
- Implement a teardown function to allow running multiple scenarios.

### 15. **[test: :test_tube::x: Create specification for the registry – interface for persistent storage](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/72d31a62cc661b545aa25e4181a90f6b6c76867b)**
- Add unit tests for an object that the app will interact with to store data to a persistent storage.
- This is an implementation detail of the app, it doesn't change the behavior of the app – tests are added to `tests/testthat/`, no changes in acceptance tests are needed.

### 16. **[test: :test_tube::x: Add specification for CSV storage](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/f7b572f3bb29a14cc95ae58c18792edf2a73fa32)**
- Create a specification for an interface that will connect the app with a CSV file.

### 17. **[feat: :test_tube::white_check_mark: Add implementation of the storage and registry](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/d30de11879113cadbe2f4dc821d796b8cdc4fb49)**
- Create an implementation objects perviously specified in tests.
- Leave the doors open for other implementations of interfaces so that we could extend the implementation to use a database or a S3 bucket.
- The new code is not used in the app code yet. We will do that in the next commits.

### 18. **[feat: :test_tube::white_check_mark: Integrate storage code with the app](https://github.com/jakubsob/acceptance-tdd-shiny-development/commit/fb6049716eea6eda29b8e20745c35d637969f7a8)**
- Use new interface of saving inputs in the app.
- Update the acceptance test so that each test case uses it's own storage, making them independent of each other.


<!-- END_COMMITS -->
