import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'formFeedback', 'overlay' ]

  connect() {
    console.log('coucou')
  }

  openModal() {
    this.overlayTarget.classList.toggle('container-overlay')
    this.formFeedbackTarget.classList.toggle('open-modal')

  }
}
