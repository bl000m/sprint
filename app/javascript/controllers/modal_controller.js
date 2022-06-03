import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['card']
  flip() {

    this.cardTarget.classList.toggle('anim-card')
  }
}




// je clic sur le bouton detail
// le clic declenche un evenement
// la classe active s'ajoute au modal pour le rendre visible
// la classe active s'ajoute à l'overlay
// la classe active s'en va lorsque je clique sur la croix
// la classe active s'en va lorsque je clique en dehors du modal
