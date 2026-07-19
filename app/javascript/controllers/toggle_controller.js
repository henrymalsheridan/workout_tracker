import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
static targets = ["strengthFields", "cardioFields"]

  switch(event) {
    if (event.target.checked) {
      // If checked hide reps/weight and show duration
      this.strengthFieldsTarget.classList.add("hidden")
      this.cardioFieldsTarget.classList.remove("hidden")
    } else {
      // unchecked show reps/weight and hide duration
      this.strengthFieldsTarget.classList.remove("hidden")
      this.cardioFieldsTarget.classList.add("hidden")
    }
  }
}