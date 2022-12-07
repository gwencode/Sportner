import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["runLevel", "surfLevel"]

  connect() {
  }

  displayRunLevel(e) {
    if (e.currentTarget.value === "true") {
      this.runLevelTarget.classList.remove("d-none")
    }  else {
      this.runLevelTarget.classList.add("d-none")
    }
  }
  displaySurfLevel(e) {
    if (e.currentTarget.value === "true") {
      this.surfLevelTarget.classList.remove("d-none")
    }  else {
      this.surfLevelTarget.classList.add("d-none")
    }
  }
}
