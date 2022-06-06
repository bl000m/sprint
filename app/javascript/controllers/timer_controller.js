import { Controller } from "stimulus"

export default class extends Controller {
  static values = {
    start: String
  }

  connect() {
    console.log('je suis dans connect')
    this.myInterval = setInterval(this.myTimer.bind(this), 1000)
    // console.log('connected to the Timer controller')
  }

  disconnect() {
    console.log('je usis dans le disconnect')
    clearInterval(this.myInterval)
  }

  myTimer() {
    console.log('je suis dans myTimer')
    const date = Date.parse(new Date()) - Date.parse(this.startValue)
    this.element.innerHTML = this.msToTime(date)
  }

  msToTime(duration) {
    console.log("I'm here")
    var seconds = Math.floor((duration / 1000) % 60),
    minutes = Math.floor((duration / (1000 * 60)) % 60),
    hours = Math.floor((duration / (1000 * 60 * 60)) % 24);

    hours = (hours < 10) ? "0" + hours : hours;
    minutes = (minutes < 10) ? "0" + minutes : minutes;
    seconds = (seconds < 10) ? "0" + seconds : seconds;
    console.log(hours)
    return hours + ":" + minutes + ":" + seconds;
    console.log(timePassing)
    }
}
