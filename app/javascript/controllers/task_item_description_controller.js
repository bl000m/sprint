import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "description", "resize", "changeBackground" ]

  showDescription() {
    this.descriptionTarget.classList.toggle('open-description')
    this.resizeTarget.classList.toggle('resize-wrapper')

  }

  // resizeContainer() {
  //   console.log('je suis dans resize')
  //   // this.resizeTarget.classList.toggle('resize-card-container')
  // }
}
