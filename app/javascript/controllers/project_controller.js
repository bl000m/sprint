import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "board", "list" ]
  static values =  {
    token: String,
    api: String
  }

  connect() {
    fetch(`https://api.trello.com/1/members/me/boards?key=${this.apiValue}&token=${this.tokenValue}`)
      .then(response => response.json())
      .then(data => {
        data.forEach(item => {
          var board = item.name
          var option = document.createElement("option");
          option.value = board
          option.text = board
          this.boardTarget.add(option)
        });
      })
  }

  trello(event) {
    event.preventDefault()
    const board = this.boardTarget.value
    fetch(`https://api.trello.com/1/members/me/boards?key=${this.apiValue}&token=${this.tokenValue}`)
      .then(response => response.json())
      .then(data => {
        var boardSelected = data.find(data => data.name === board)
        var boardId = boardSelected.id
        fetch(`https://api.trello.com/1/boards/${boardId}/lists?key=${this.apiValue}&token=${this.tokenValue}`)
        .then(response => response.json())
          .then(data => {
            let li = `<tr><th></th></tr>`
            data.forEach(item => {
              var listId = item.id
              var listName = item.name
              li += `<p data-controller="cards"
                        data-action="click->cards#tasks"
                        data-cards-target="result"
                        data-cards-token-value=${this.tokenValue}
                        data-cards-api-value=${this.apiValue}
                        data-cards-item-id-value=${listId}>${listName}</p>`
              this.element.innerHTML = li
            });
          })
      })
    }
}
