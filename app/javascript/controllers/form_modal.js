import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'formModal' ]

  OpenModal() {
    console.log('coucou')
    this.formModalTarget.classList.toggle('.open-modal')
  }
}
