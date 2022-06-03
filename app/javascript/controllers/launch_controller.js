import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['deploy']

  openLaunch() {
    this.deployTarget.classList.toggle('open-bottom-card-container')
  }
}
