import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["run"]
  connect() {
    console.log("Hello from run toggle 2 controller")
  }

  filter() {
    console.log("Test toggle ")
    this.runTarget.classList.toggle("select")
  }
}
