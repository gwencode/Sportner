import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="preview-input"
export default class extends Controller {
  static targets=["input","input2","input3", "image", "image2", "image3"]

  changeSrc(reader) {
    this.imageTarget.src = reader.target.result
   }
   changeSrc2(reader) {
    this.image2Target.src = reader.target.result
   }
   changeSrc3(reader) {
    this.image3Target.src = reader.target.result
   }

  changeImage(){
    const oFReader = new FileReader()
    oFReader.readAsDataURL(this.inputTarget.files[0])

    oFReader.onload = this.changeSrc.bind(this)
  }
  changeImage2(){
    const oFReader = new FileReader()
    oFReader.readAsDataURL(this.input2Target.files[0])

    oFReader.onload = this.changeSrc2.bind(this)
  }
  changeImage3(){
    const oFReader = new FileReader()
    oFReader.readAsDataURL(this.input3Target.files[0])

    oFReader.onload = this.changeSrc3.bind(this)
  }
  openFile(){
    this.inputTarget.click()
  }
  openFile2(){
    this.input2Target.click()
  }
  openFile3(){
    this.input3Target.click()
  }
}
