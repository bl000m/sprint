import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [ "currentMission", "doneItems" ]
  static values = {
    realTime: Number
  }


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
      this.currentMissionTarget.innerHTML = data
    })
  }

  // #moving
  done(event) {
    console.log('je suis done')
    console.log(`id: ${event.currentTarget.dataset.taskId}`)
    console.log(this.doneItemsTarget)
    const taskId = event.currentTarget.dataset.taskId

    this.pause()
    // this.currentMissionTarget.outerHTML = "<p>Done !</p>"
    fetch(`/tasks/${taskId}/done`,
    {
      method: "POST",
      headers: {
        "X-CSRF-Token": csrfToken(),
        accept: "text/plain"
      }
    })
    .then(response => response.text())
    .then((data) => {
      this.currentMissionTarget.innerHTML = ""
      this.doneItemsTarget.insertAdjacentHTML("beforeend", data)
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
          this.currentMissionTarget.innerHTML = data

        })
  }

  startTask(e) {
    this.createMission(e.currentTarget.dataset.taskId)
    document.getElementById(e.currentTarget.dataset.taskId).remove()
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
