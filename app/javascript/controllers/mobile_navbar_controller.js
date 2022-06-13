import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mobile-navbar"
export default class extends Controller {
  static classes = [ "active" ]
  connect() {
    // console.log("Hi from the mobile navbar controller!")
  }

  active(e) {
    // console.log(e)
    e.target.classList.toggle("active")
  }
}
