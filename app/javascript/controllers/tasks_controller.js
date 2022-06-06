import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [ "currentMission" ]


  pause() {
    console.log('pause')

    fetch(`/missions/pause`,
    {
      method: "POST",
      headers: {
        "X-CSRF-Token": csrfToken(),
        accept: "text/plain"
      }
    })
    .then(response => response.text())
    .then((data) => {
      this.currentMissionTarget.outerHTML = data
    })
  }

  createMission(taskId) {
    console.log(`je crée ma mission avec comme id ${taskId}`)
    fetch(`/tasks/${taskId}/missions`,
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
          console.log(data)
          this.currentMissionTarget.outerHTML = data
        })
  }

  startTask(e) {
    this.createMission(e.currentTarget.dataset.taskId)
  }
}



// import { Controller } from "stimulus"
// import { end } from "@popperjs/core";

// export default class extends Controller {
//   static targets = [ "missionList"]
//   connect() {
//     console.log("connected", this)
//     console.log(this.missionListTarget)
//   }
