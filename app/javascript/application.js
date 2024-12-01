// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";


document.addEventListener("DOMContentLoaded", () => {
  const percentageButtons = document.querySelectorAll(".tip-btn");
  const customTipInput = document.getElementById("custom-tip");
  const tipInput = document.getElementById("tip");
  const form = document.getElementById("tip-form");
  const calculateButton = document.getElementById("calculate-button");
  const tipAmountField = document.getElementById("tip-amount");
  const totalField = document.getElementById("total");

  // Add event listener to percentage buttons
  percentageButtons.forEach((button) => {
    button.addEventListener("click", () => {
      percentageButtons.forEach((btn) => btn.classList.remove("selected"));
      button.classList.add("selected");
      customTipInput.classList.remove("selected");
      tipInput.value = button.dataset.value;
    });
  });

  customTipInput.addEventListener("input", () => {
    percentageButtons.forEach((btn) => btn.classList.remove("selected"));
    customTipInput.classList.add("selected");

    tipInput.value = customTipInput.value;
  });

  // Handle form submission via Ajax
  function handleFormSubmission(event) {
    event.preventDefault();

    // Clear previous error messages
    document.getElementById("bill-error").textContent = "";
    document.getElementById("tip-error").textContent = "";
    document.getElementById("people-error").textContent = "";
    document.getElementById("bill").classList.remove("error");
    document.getElementById("tip").classList.remove("error");
    document.getElementById("number_of_people").classList.remove("error");

    //Validate form fields on the client side
    let isValid = true;

    const bill = document.getElementById("bill").value;
    const tipPercentage = document.getElementById("tip").value;
    const numberOfPeople = document.getElementById("number_of_people").value;

    if (!bill || bill <= 0) {
      document.getElementById("bill-error").textContent = "! Can't be zero";
      document.getElementById("bill").classList.add("error");
      isValid = false;
    }
    if (!tipPercentage || tipPercentage <= 0) {
      document.getElementById("tip-error").textContent = "! Can't be zero";
      document.getElementById("tip").classList.add("error");
      isValid = false;
    }
    if (!numberOfPeople || numberOfPeople <= 0) {
      document.getElementById("people-error").textContent = "! Can't be zero";
      document.getElementById("number_of_people").classList.add("error");
      isValid = false;
    }
    if (!isValid) {
      return;
    }

    calculateButton.value = "Calculating...";
    calculateButton.disabled = true;
    // Manually construct the FormData in the format Rails expects
    const formData = new URLSearchParams();
    formData.append("tip[bill]", document.getElementById("bill").value);
    formData.append(
      "tip[tip_percentage]",
      document.getElementById("tip").value
    );
    formData.append(
      "tip[number_of_people]",
      document.getElementById("number_of_people").value
    );

    fetch(form.action, {
      method: form.method,
      body: formData,
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
          .content,
      },
    })
      .then((response) => {
        if (!response.ok) {
          console.log(response.json());
          throw new Error(`Server error: ${response.statusText}`);
        }
        return response.json();
      })
      .then((data) => {
        // Update UI with results
        tipAmountField.textContent = data.per_person_tip;
        totalField.textContent = data.per_person;
        calculateButton.value = "RESET"; // Change button text to "Reset"
        calculateButton.disabled = false;

        calculateButton.removeEventListener("click", handleCalculateClick); // Remove the calculate click listener
        calculateButton.addEventListener("click", handleResetClick); // Add the reset click listener
      })
      .catch((error) => {
        console.error("Error:", error);
        alert("Something went wrong! " + error.message);

        calculateButton.textContent = "RESET";
        calculateButton.disabled = false;
        calculateButton.removeEventListener("click", handleCalculateClick);
        calculateButton.addEventListener("click", handleResetClick);
      });
  }

  // Handle Reset Click
  function handleResetClick(event) {
    event.preventDefault();
    form.reset(); // Reset form fields
    tipAmountField.textContent = "0.00"; // Reset tip amount field
    totalField.textContent = "0.00"; // Reset total amount field
    percentageButtons.forEach((btn) => btn.classList.remove("selected"));
    calculateButton.value = "CALCULATE"; // Change button text back to "Calculate"
    calculateButton.removeEventListener("click", handleResetClick); // Remove the reset click listener
    calculateButton.addEventListener("click", handleCalculateClick); // Add the calculate click listener again
  }

  // Initially, bind the calculate click handler
  calculateButton.addEventListener("click", handleCalculateClick);

  function handleCalculateClick(event) {
    event.preventDefault();
    handleFormSubmission(event); // Call the Ajax form submission function
  }
});
