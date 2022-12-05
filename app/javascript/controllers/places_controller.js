import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["infobtn", "meteobtn", "photosbtn",
                    "info", "meteo", "photos"]
  connect() {
    console.log("Hello from places controler")
  }

  infoDisplay() {
    console.log(this.infobtnTarget)

    this.infobtnTarget.setAttribute("disabled", "")
    this.meteobtnTarget.removeAttribute("disabled", "")
    this.photosbtnTarget.removeAttribute("disabled", "")

    this.infoTarget.classList.remove("d-none");
    this.meteoTarget.classList.add("d-none");
    this.photosTarget.classList.add("d-none");

    this.infobtnTarget.classList.remove("place-disable");
    this.meteobtnTarget.classList.add("place-disable");
    this.photosbtnTarget.classList.add("place-disable");
  }

  meteoDisplay() {
    console.log(this.meteobtnTarget)

    this.meteobtnTarget.setAttribute("disabled", "")
    this.infobtnTarget.removeAttribute("disabled", "")
    this.photosbtnTarget.removeAttribute("disabled", "")

    this.meteoTarget.classList.remove("d-none");
    this.infoTarget.classList.add("d-none");
    this.photosTarget.classList.add("d-none");

    this.meteobtnTarget.classList.remove("place-disable");
    this.infobtnTarget.classList.add("place-disable");
    this.photosbtnTarget.classList.add("place-disable");
  }

  photosDisplay() {
    console.log(this.photosbtnTarget)

    this.photosbtnTarget.setAttribute("disabled", "")
    this.meteobtnTarget.removeAttribute("disabled", "")
    this.infobtnTarget.removeAttribute("disabled", "")

    this.photosTarget.classList.remove("d-none");
    this.meteoTarget.classList.add("d-none");
    this.infoTarget.classList.add("d-none");

    this.photosbtnTarget.classList.remove("place-disable");
    this.meteobtnTarget.classList.add("place-disable");
    this.infobtnTarget.classList.add("place-disable");
  }


}
