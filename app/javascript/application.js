// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";

document.addEventListener("turbo:load", () => {
  const elements = {
    percentageButtons: document.querySelectorAll(".tip-btn"),
    customTipInput: document.getElementById("custom-tip"),
    tipInput: document.getElementById("tip"),
    form: document.getElementById("tip-form"),
    calculateButton: document.getElementById("calculate-button"),
    tipAmountField: document.getElementById("tip-amount"),
    totalField: document.getElementById("total"),
    bill: document.getElementById("bill"),
    tipPercentage: document.getElementById("tip"),
    numberOfPeople: document.getElementById("number_of_people"),
    errors: {
      bill: document.getElementById("bill-error"),
      tipInput: document.getElementById("tip-error"),
      numberOfPeople: document.getElementById("people-error"),
    },
  };

  // Utility Functions
  const clearErrors = () => {
    Object.values(elements.errors).forEach(
      (errorField) => (errorField.textContent = "")
    );
    [elements.bill, elements.tipPercentage, elements.numberOfPeople].forEach(
      (field) => field.classList.remove("error")
    );
  };

  const setError = (field, message) => {
    elements.errors[field].textContent = message;
    elements[field].classList.add("error");
  };

  const validateFields = () => {
    let isValid = true;

    const billValue = elements.bill.value;
    const tipValue = elements.tipPercentage.value;
    const peopleValue = elements.numberOfPeople.value;

    if (!billValue || billValue <= 0) {
      setError("bill", "! Can't be zero");
      isValid = false;
    }
    if (!tipValue || tipValue <= 0) {
      setError("tipInput", "! Can't be zero");
      isValid = false;
    }
    if (!peopleValue || peopleValue <= 0) {
      setError("numberOfPeople", "! Can't be zero");
      isValid = false;
    }

    return isValid;
  };

  const toggleButtonState = (text, disabled) => {
    elements.calculateButton.value = text;
    elements.calculateButton.disabled = disabled;
  };

  // Event Listeners
  const handlePercentageButtonClick = (button) => {
    elements.percentageButtons.forEach((btn) =>
      btn.classList.remove("selected")
    );
    button.classList.add("selected");
    elements.customTipInput.classList.remove("selected");
    elements.tipInput.value = button.dataset.value;
  };

  elements.percentageButtons.forEach((button) => {
    button.addEventListener("click", () => handlePercentageButtonClick(button));
  });

  elements.customTipInput.addEventListener("input", () => {
    elements.percentageButtons.forEach((btn) =>
      btn.classList.remove("selected")
    );
    elements.customTipInput.classList.add("selected");
    elements.tipInput.value = elements.customTipInput.value;
  });

  const handleFormSubmission = (event) => {
    event.preventDefault();
    clearErrors();

    if (!validateFields()) return;

    toggleButtonState("Calculating...", true);

    const formData = new URLSearchParams({
      "tip[bill]": elements.bill.value,
      "tip[tip_percentage]": elements.tipPercentage.value,
      "tip[number_of_people]": elements.numberOfPeople.value,
    });

    fetch(elements.form.action, {
      method: elements.form.method,
      body: formData,
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
          .content,
      },
    })
      .then((response) => {
        if (!response.ok)
          return response.json().then((data) => Promise.reject(data));
        return response.json();
      })
      .then((data) => {
        elements.tipAmountField.textContent = data.per_person_tip;
        elements.totalField.textContent = data.per_person;

        toggleButtonState("RESET", false);
        elements.calculateButton.removeEventListener(
          "click",
          handleCalculateClick
        );
        elements.calculateButton.addEventListener("click", handleResetClick);
      })
      .catch((error) => {
        console.error("Error:", error);
        alert("Something went wrong! Please try again.");
        toggleButtonState("RESET", false);
        elements.calculateButton.removeEventListener(
          "click",
          handleCalculateClick
        );
        elements.calculateButton.addEventListener("click", handleResetClick);
      });
  };

  const handleResetClick = (event) => {
    event.preventDefault();
    elements.form.reset();
    elements.tipAmountField.textContent = "0.00";
    elements.totalField.textContent = "0.00";
    elements.percentageButtons.forEach((btn) =>
      btn.classList.remove("selected")
    );
    toggleButtonState("CALCULATE", false);
    elements.calculateButton.removeEventListener("click", handleResetClick);
    elements.calculateButton.addEventListener("click", handleCalculateClick);
  };

  const handleCalculateClick = (event) => handleFormSubmission(event);

  elements.calculateButton.addEventListener("click", handleCalculateClick);
});
