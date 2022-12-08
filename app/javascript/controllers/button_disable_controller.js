import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["btndisable"]

  connect() {
    // console.log("Hello from btn disable controler")
    // console.log(this.btndisableTarget)
    this.btndisableTarget.setAttribute("disabled", "")
  }
}
