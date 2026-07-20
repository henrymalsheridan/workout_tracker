import { Controller } from "@hotwired/stimulus"

//Connects to data-controller
export default class extends Controller {
  static targets = ["template", "target"]

  // customizable value that defaults to "NEW_RECORD"
  static values = { placeholder: { type: String, default: "NEW_RECORD" } }

  add(event) {
    event.preventDefault()
    event.stopPropagation()
    //Use placeholder string to build regex
    const placeholder = this.element.dataset.placeholder || "NEW_RECORD"
    const regex = new RegExp(this.placeholderValue, 'g')
    
    
    //Replace string with the unique timestamp
    const content = this.templateTarget.innerHTML.replace(regex, new Date().getTime())    
    // Inject HTML into the form
    this.targetTarget.insertAdjacentHTML('beforeend', content)
  }

  remove(event) {
    event.preventDefault()
    event.stopPropagation()
    let wrapper = event.target.closest(".nested-fields")
    
    // Find the hidden destroy input and set it to 1
    let destroyInput = wrapper.querySelector("input[name*='_destroy']")
    if (destroyInput) destroyInput.value = "1"
    
    // Visually hide the fields
    wrapper.style.display = 'none'
  }
}
