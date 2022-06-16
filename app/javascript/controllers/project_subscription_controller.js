import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"
import swal from 'sweetalert';


export default class extends Controller {
  static values = { projectId: Number }
  static targets = ["messages", "message"]

  connect() {
    console.log(this.messageTargets)
    console.log(this.element.dataset.currentUser)
    console.log(this.element.dataset)
    this.currentUser = this.element.dataset.currentUser;
    this.currentUserName = this.element.dataset.currentUserName;
    console.log(this.messagesTarget.lastElementChild.dataset)
    this.messagesTarget.lastElementChild.scrollIntoView()
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
    console.log(this.messagesTarget.lastElementChild)
    console.log(this.currentUser)
    if (this.messagesTarget.lastElementChild.dataset.sender !== this.currentUser) {
      this.messagesTarget.lastElementChild.classList.add("message-left");
      this.messagesTarget.lastElementChild.classList.remove("message-right");
      swal(`Hello, ${this.element.dataset.currentUserName}! You have a new message from ${this.messagesTarget.lastElementChild.dataset.senderName}!`);
    } else {
      this.messagesTarget.lastElementChild.classList.add("message-right");
      this.messagesTarget.lastElementChild.classList.remove("message-left");
    }
  }
}
