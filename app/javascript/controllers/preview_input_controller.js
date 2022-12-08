import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="preview-input"
export default class extends Controller {
  static targets=["input", "image", "carpoolingField"]

  changeSrc(reader) {
    this.imageTarget.src = reader.target.result
   }

  changeImage(){
    const oFReader = new FileReader()
    oFReader.readAsDataURL(this.inputTarget.files[0])

    oFReader.onload = this.changeSrc.bind(this)
  }

  openFile(){
    this.inputTarget.click()
  }

  checkCarpooling(e) {
    e.currentTarget.checked ? this.carpoolingFieldTarget.classList.remove('d-none') : this.carpoolingFieldTarget.classList.add('d-none')
  }
}
