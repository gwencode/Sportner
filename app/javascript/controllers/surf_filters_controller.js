import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["surf"]
  connect() {
    console.log("Hello from surf toggle controller")
  }

  filter() {
    console.log("Test surf toggle")
    this.surfTarget.classList.toggle("select")
  }
}
