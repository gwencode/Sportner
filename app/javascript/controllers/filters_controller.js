import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["runbtn", "surfbtn", "runcard", "surfcard"]
  connect() {
    console.log("Hello from filter controler")
    console.log(this.runcardTargets)
    console.log(this.surfcardTargets)
  }

  runfilter() {
    this.runbtnTarget.classList.toggle("select");
    this.runcardTargets.forEach((target) => target.classList.toggle("d-none"));
  }

  surffilter() {
    this.surfbtnTarget.classList.toggle("select");
    this.surfcardTargets.forEach((target) => target.classList.toggle("d-none"));
  }
}
