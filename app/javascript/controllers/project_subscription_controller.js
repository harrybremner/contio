import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"
import swal from 'sweetalert';


export default class extends Controller {
  static values = { projectId: Number }
  static targets = ["messages", "message"]

  connect() {
    console.log(this.messageTargets)
    console.log(this.element.dataset.currentUser)
    this.channel = createConsumer().subscriptions.create(
      { channel: "ProjectChannel", id: this.projectIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
    )
    console.log(`Subscribed to the project with the id ${this.projectIdValue}.`)
  }

  resetForm(event) {
    event.target.reset()
  }

  disconnect() {
    // console.log("Unsubscribed from the project chatroom")
    // this.channel.unsubscribe()
  }

  #insertMessageAndScrollDown(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
    // this.element.dataset.currentUser
    // alert("Hello, Harry! You have a new message from George!")
    swal("Hello, Harry! You have a new message from George!");
  }
}
