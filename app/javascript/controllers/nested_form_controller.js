import { Controller } from "@hotwired/stimulus"

//Connects to data-controller
export default class extends Controller {
  static targets = ["template", "target"]

  add(event) {
    event.preventDefault()
    //Generate a unique ID using the current time
    let time = new Date().getTime()
    
    //Replace 'NEW_RECORD' in with the unique ID
    let content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, time)
    
    // Inject HTML into the form
    this.targetTarget.insertAdjacentHTML('beforeend', content)
  }

  remove(event) {
    event.preventDefault()
    let wrapper = event.target.closest(".nested-fields")
    
    // Find the hidden destroy input and set it to 1
    let destroyInput = wrapper.querySelector("input[name*='_destroy']")
    if (destroyInput) destroyInput.value = "1"
    
    // Visually hide the fields
    wrapper.style.display = 'none'
  }
}
