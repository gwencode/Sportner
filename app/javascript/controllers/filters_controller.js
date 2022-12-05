import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["runbtn", "surfbtn",
                    "runcard", "surfcard",
                    "rangedate",
                    "runform", "surfform",
                    "futurbtn", "pastbtn",
                    "myfuturevents", "mypastevents"]
  connect() {
    console.log("Hello from filter controler")
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
    const dates = this.rangedateTarget.value.split(' to ');

    console.log(dates);
    const startdate = dates[0];
    const enddate = dates[1];
    console.log(startdate);
    console.log(enddate);
  }

  formRunDisplay() {
    this.runbtnTarget.classList.add("select");
    this.surfbtnTarget.classList.remove("select");

    this.runbtnTarget.setAttribute("disabled", "")
    this.surfbtnTarget.removeAttribute("disabled", "")

    this.runformTarget.classList.remove("d-none");
    this.surfformTarget.classList.add("d-none");
  }

  formSurfDisplay() {
    this.surfbtnTarget.classList.add("select");
    this.runbtnTarget.classList.remove("select");

    this.surfbtnTarget.setAttribute("disabled", "")
    this.runbtnTarget.removeAttribute("disabled", "")

    this.surfformTarget.classList.remove("d-none");
    this.runformTarget.classList.add("d-none");
  }

  myFuturEventsDisplay() {
    console.log(this.futurbtnTarget)

    this.futurbtnTarget.setAttribute("disabled", "")
    this.pastbtnTarget.removeAttribute("disabled", "")

    this.myfutureventsTarget.classList.remove("d-none");
    this.mypasteventsTarget.classList.add("d-none");

    this.futurbtnTarget.classList.remove("temporal-disable");
    this.pastbtnTarget.classList.add("temporal-disable");
  }

  myPastEventsDisplay() {
    console.log(this.pastbtnTarget)

    this.pastbtnTarget.setAttribute("disabled", "")
    this.futurbtnTarget.removeAttribute("disabled", "")

    this.mypasteventsTarget.classList.remove("d-none");
    this.myfutureventsTarget.classList.add("d-none");

    this.futurbtnTarget.classList.add("temporal-disable");
    this.pastbtnTarget.classList.remove("temporal-disable");
  }
}
