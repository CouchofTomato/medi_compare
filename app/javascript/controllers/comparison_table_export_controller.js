import { Controller  } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ["param"]

  excelExport(event) {
    let queryParams = this.parameterise()
    const csrfToken = document.querySelector("[name='csrf-token']").content
    fetch(`/comparisons/show?${queryParams}`, {
      method: "get",
      headers: {
        "X-CSRF-Token": csrfToken,
      },
    })
  }

  parameterise() {
    return this.paramTargets.map(target => {
      const dataParams = JSON.parse(target.getAttribute("data-params"))
      return this.queryString(dataParams)
    }).join("&")
  }

  queryString(dataParams) {
    return Object.entries(dataParams).map(([key, val]) => {
      if(typeof val === "object") {
        return Object.entries(val).map(([key2, val2]) => encodeURI(`selected_products[][${key}][${key2}]=${val2}`)).join('&')
      } else {
        return(encodeURI(`selected_products[][${key}]=${val}`))
      }
    }).join("&")
  }
}
