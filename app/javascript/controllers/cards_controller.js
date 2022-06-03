import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "result", "cards" ]
  static values =  {
    itemId: String,
    token: String,
    api: String
  }


  tasks(event) {
    event.preventDefault()
    fetch(`https://api.trello.com/1/lists/${this.itemIdValue}/cards?key=${this.apiValue}&token=${this.tokenValue}`)
    .then(response => response.json())
    .then(data => {
      let li = `<tr><th></th></tr>`
      data.forEach(item => {
        var cardName = item.name
        // li += `<p>${cardName}</p>`
        li += `<a href='http://localhost:3000/tasks'>${cardName}</a> <br>`
        this.element.innerHTML = li
        // cardsTarget.innerHTML = li
      });
    })
  }

  //comment cacher les autres listes qui restent affichés?

  // comment utiliser method post pour faire passer une cards de TO DO à IN PROGRESS sur Trello
  //quand une tache est selectionné et play est demarré



  // // alternatif avec method post
  // tasks(event) {
  //   event.preventDefault()
  //   fetch(`https://api.trello.com/1/lists/${this.itemIdValue}/cards?key=${this.apiValue}&token=${this.tokenValue}`, {
  //     method: "POST",
  //     body: JSON.stringify({
  //       title: "foo",
  //       body: "bar"
  //     }),
  //     headers: {
  //     "Content-type": "application/json; charset=UTF-8"
  //     }
  //   })
  //   .then(response => response.json())
  //   .then(data => {
  //     let li = `<tr><th></th></tr>`
  //     data.forEach(item => {
  //       var cardName = item.name
  //       li += `<p>${cardName}</p>`
  //       this.element.innerHTML = li
  //     });
  //   })
  // }
  // //fin alternatif method post

}
