import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = [ "Date", "Calendar" ]
  connect() {
    console.log("hello")
    if (this.hasCalendarTarget) {
      flatpickr(this.CalendarTarget, { mode: "range" })
    }
    if (this.hasDateTarget) {
      flatpickr(this.DateTarget, {
        enableTime: true,
        dateFormat: "Y-m-d H:i",
        minDate: "today",
      })
    }
  }
}
