import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["source", "filterable"]

  filter(event) {
    let lowerCaseFilterTerm = this.sourceTarget.value.toLowerCase()
    console.log(this.filterableTargets)

    this.filterableTargets.forEach((el, i) => {
      let filterableKey = el.getAttribute("data-filter-key")

      el.classList.toggle("filter--notFound", !filterableKey.includes(lowerCaseFilterTerm))
    })
  }
}
