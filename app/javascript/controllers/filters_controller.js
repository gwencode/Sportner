import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["runbtn", "surfbtn", "runcard", "surfcard", "rangedate"]
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

  datefilter() {
    // console.log(this.rangedateTarget.value.split());
    const dates = this.rangedateTarget.value.split();
    console.log(dates);
    // console.log(dates[0].split("-"));
    // const startdate = dates[0].split("-");
    // console.log(startdate)
    // console.log(startdate.class)
    // const enddate = dates.last.first.split("-");
    // console.log(startdate);
    // console.log(enddate);
  }
}
