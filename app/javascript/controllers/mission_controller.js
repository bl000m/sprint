import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";
import { end } from "@popperjs/core";

export default class extends Controller {
  static targets = [ "missionList"]
  connect() {
    console.log("connected", this)
    console.log(this.missionListTarget)
  }

  createMission(event) {
    console.log(`je crée ma mission avec comme id ${event.currentTarget.dataset.id} `)
    fetch(`/tasks/${event.currentTarget.dataset.id}/missions`,
      {
        method: "POST",
        headers: {
          "X-CSRF-Token": csrfToken(),
          accept: "text/plain"
        }
      }).then(response => response.text())
        .then((data) => {
          console.log('toto')
          console.log(data)
          console.log(this.missionListTarget)
          this.missionListTarget.insertAdjacentHTML("beforeend", data)
          // console.log(data)
        })
  }
}
