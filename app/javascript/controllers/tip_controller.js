// import { Controller } from "@hotwired/stimulus";

// export default class extends Controller {
//   static targets = [
//     "bill",
//     "tip",
//     "people",
//     "tipAmount",
//     "total",
//     "calculateButton",
//   ];

//   setTip(event) {
//     event.preventDefault();
//     const tipPercentage = event.target.getAttribute("value");
//     this.tipTarget.value = tipPercentage;
//     this.calculate();
//   }

//   handleButtonClick(event) {
//     if (this.calculateButtonTarget.innerText === "Calculate") {
//       this.calculate();
//       if (this.peopleTarget.value > 0) {
//         this.calculateButtonTarget.innerText = "Reset";
//       } else {
//         alert("Number of people cannot be zero.");
//       }
//     } else {
//       this.resetForm();
//       this.calculateButtonTarget.innerText = "Calculate";
//     }
//   }

//   calculate() {
//     const bill = parseFloat(this.billTarget.value) || 0;
//     const tipPercentage = parseFloat(this.tipTarget.value) || 0;
//     const people = parseInt(this.peopleTarget.value) || 1;

//     if (people === 0) {
//       alert("Number of people cannot be zero.");
//       return;
//     }

//     const tipAmount = ((bill * tipPercentage) / 100).toFixed(2);
//     const total = (bill + parseFloat(tipAmount)) / people;
//     this.tipAmountTarget.innerText = `$${tipAmount}`;
//     this.totalTarget.innerText = `$${total.toFixed(2)}`;
//   }

//   resetForm() {
//     this.billTarget.value = "";
//     this.tipTarget.value = "";
//     this.peopleTarget.value = "";
//     this.tipAmountTarget.innerText = "$0.00";
//     this.totalTarget.innerText = "$0.00";
//   }
// }
