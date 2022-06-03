import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "board", "list" ]
  static values =  {
    token: String,
    api: String
  }

  stepBoards() {
    fetch('/projects/new/boards')
      .then(response => response.text())
      .then(html => this.element.innerHTML = html)
  }

  selectBoard(e) {
    console.log('je veux select une board')
    console.log(e.currentTarget)
    console.log(e.currentTarget.dataset.name)
    console.log(e.currentTarget.dataset.id)
    const name = e.currentTarget.dataset.name
    const boardId = e.currentTarget.dataset.id
    fetch(`/projects/new/form?name=${name}&board_id=${boardId}`)
      .then(response => response.text())
      .then(html => this.element.innerHTML = html)
  }

  connect() {
    console.log('couazdzedcou')
    this.stepBoards()
    // fetch(`https://api.trello.com/1/members/me/boards?key=${this.apiValue}&token=${this.tokenValue}`)
    //   .then(response => response.json())
    //   .then(data => {
    //     data.forEach(item => {
    //       var board = item.name
    //       var option = document.createElement("option");
    //       option.value = board
    //       option.text = board
    //       this.boardTarget.add(option)
    //     });
    //   })
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
