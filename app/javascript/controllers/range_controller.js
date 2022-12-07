import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["distance", "time"]

  connect() {
    console.log("coucou")
    console.log(this.distanceTarget)
    console.log(this.timeTarget)
  }

  displayValue()
    // console.log()
}
