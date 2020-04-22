import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["comparisonTable", "deleteColumn"]

  deleteColumn(event) {
    let cell = event.target.closest('td')
    let cellIndex = cell.cellIndex
    let rows = Array.from(this.comparisonTableTarget.rows)
    rows.forEach(row => {
      if(row.classList.contains("dropdown")) return;

      row.deleteCell(cellIndex)
    })
  }
}
