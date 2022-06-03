import { Controller } from "stimulus"

export default class extends Controller {
  static values = {
    start: String
  }

  connect() {
    setInterval(this.myTimer(), 1000)
  }

  myTimer() {
    const date = Date.parse(new Date()) - Date.parse(this.startValue)
    this.element.innerHTML = this.msToTime(date);
  }

  msToTime(duration) {

    var seconds = Math.floor((duration / 1000) % 60),
    minutes = Math.floor((duration / (1000 * 60)) % 60),
    hours = Math.floor((duration / (1000 * 60 * 60)) % 24);

    hours = (hours < 10) ? "0" + hours : hours;
    minutes = (minutes < 10) ? "0" + minutes : minutes;
    seconds = (seconds < 10) ? "0" + seconds : seconds;

    return hours + ":" + minutes + ":" + seconds;
  }
}
