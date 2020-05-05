import { Controller  } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ["param"]

  excelExport(event) {
    let formattedParams = this.formattedSelectedProductParams()
    const csrfToken = document.querySelector("[name='csrf-token']").content
    fetch(`/comparisons/show?${formattedParams}.xlsl`, {
      method: "get",
      headers: {
        "X-CSRF-Token": csrfToken,
      },
    })
  }

  formattedSelectedProductParams() {
    return this.getSelectedProducts().map(param => {
      return Object.entries(param).map(([key, val]) => `selected_products[][${key}]=${JSON.stringify(val)}`).join('&')
    }).join("&")

  }

  getSelectedProducts() {
    return this.paramTargets.map(target => {
      return JSON.parse(target.getAttribute("data-params"))
    })
  }
}
