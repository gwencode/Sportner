import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["runbtn", "surfbtn",
                    "runcard", "surfcard",
                    "rangedate",
                    "runform", "surfform",
                    "runbtndisable",
                    "futurbtn", "pastbtn",
                    "myfuturevents", "mypastevents"]
  connect() {
    console.log("Hello from filter controler")
    // voir avec Lomig comment ajouter un if si on se trouve sur telle page
    this.runbtndisableTarget.setAttribute("disabled", "")
    // this.futurbtndisableTarget.setAttribute("disabled", "")
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
