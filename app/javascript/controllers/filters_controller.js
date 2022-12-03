import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["run", "surf"]
  connect() {
  }

  runfilter() {
    this.runTarget.classList.toggle("select")
  }

  surffilter() {
    this.surfTarget.classList.toggle("select")
  }
}
