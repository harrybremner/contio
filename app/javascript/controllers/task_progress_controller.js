import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task-progress"
export default class extends Controller {
  static targets = ["complete", "svg", "percentage"]
  // connect() {
  //   console.log(this.completeTargets)
  //   console.log(this.svgTarget)
  //   console.log(this.percentageTarget)
  }

  recalculate(e) {
    let totalCompleted = 0;
    this.completeTargets.forEach((subtask) => {
      console.log(subtask.checked)
      if (subtask.checked){
        totalCompleted += 1
      }
    })
    const percentageComplete = totalCompleted / this.completeTargets.length;
    console.log(totalCompleted)
    console.log(this.completeTargets.length)
    console.log(totalCompleted / this.completeTargets.length)
    this.svgTarget.style.strokeDashoffset = 360 * percentageComplete
    this.percentageTarget.innerText = `${Math.round(percentageComplete * 100)}%`
  }
}
