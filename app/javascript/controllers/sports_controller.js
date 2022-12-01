import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["runLevel", "surfLevel"]

  connect() {
  }

  displayRunLevel(e) {
    if (e.currentTarget.value == "true") {
      this.runLevelTarget.style.display = "block"
    }  else {
      this.runLevelTarget.style.display = "none"
    }
  }
  displaySurfLevel(e) {
    if (e.currentTarget.value == "true") {
      this.surfLevelTarget.style.display = "block"
    }  else {
      this.surfLevelTarget.style.display = "none"
    }
  }
}
