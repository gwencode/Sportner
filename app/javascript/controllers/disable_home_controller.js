import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="disable-home"
export default class extends Controller {
  static targets= ["checkbox", "button"]

  connect() {
    this.buttonTarget.setAttribute("disabled", "")
  }

  verifyCheckbox() {
   const checked = this.checkboxTargets.some((checkbox)=> {
    return checkbox.checked 
   })

   if (checked) {
    this.buttonTarget.removeAttribute("disabled")
   } else { 
    this.buttonTarget.setAttribute("disabled", "")
   }
   
  }
}
