import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sortable"
export default class extends Controller {
  connect() {
    Sortable.create(this.element, {
      ghostClass: "ghost",
      animation: 150,
      onEnd: (event) => {
        alert(`${event.oldIndex} moved to ${event.newIndex}`)
      }
    })
  }
}
