# README

This README documents the necessary steps to get the application up and running.

## Ruby Version

- Ruby 3.0.0

## System Dependencies

- Rails 6.1.4
- SQLite3 (for development and test environments)
- Node.js and Yarn (for managing JavaScript dependencies)

## Configuration

1. Clone the repository:

   ```sh
   git clone https://github.com/your-username/tip_calculator.git
   cd tip_calculator
   ```

2. Install the required gems:

   ```sh
   bundle install
   ```

3. Install JavaScript dependencies:
   ```sh
   yarn install
   ```

## Database Creation

1. Create the database:
   ```sh
   rails db:create
   ```

## Database Initialization

1. Run the database migrations:

   ```sh
   rails db:migrate
   ```

2. Seed the database (if applicable):
   ```sh
   rails db:seed
   ```

## How to Run the Test Suite

1. Ensure the test database is up-to-date:

   ```sh
   rails db:test:prepare
   ```

2. Run the tests:
   ```sh
   rails test
   ```

## Approach to Solving the Challenge

### Problem Statement

The challenge was to create a tip calculator application that allows users to input a bill amount, select a tip percentage, and specify the number of people to split the bill. The application should calculate the tip amount, total bill, and the amount per person.

### Solution

1. **Model**: Created a `Tip` model with validations to ensure the presence and numericality of the `bill`, `tip_percentage`, and `number_of_people` attributes.

2. **Controller**: Implemented the `TipsController` with `index` and `create` actions. The `index` action initializes a new `Tip` object, and the `create` action handles the form submission, calculates the tip, and returns the results as JSON.

3. **View**: Designed the `index.html.erb` view to include a form for inputting the bill amount, selecting a tip percentage, and specifying the number of people. The form uses `form_with` to submit the data via AJAX.

4. **JavaScript**: Added JavaScript to handle form submission, validate input fields, and display error messages. The JavaScript also updates the UI with the calculated results.

5. **Testing**: Added tests for the `Tip` model and `TipsController` to ensure the application works correctly and handles edge cases.

### Key Features

- Input validation to ensure valid data is submitted.
- Dynamic calculation of tip amount, total bill, and amount per person.
- Responsive design to provide a good user experience on different devices.
- Test suite to ensure the application works correctly and is maintainable.

By following these steps, the application provides a reliable and user-friendly tip calculator that meets the requirements of the challenge.
