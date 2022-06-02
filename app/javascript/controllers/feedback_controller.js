import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['feed']
  open() {

    this.feedTarget.classList.toggle('open-feed-form')
  }
}
