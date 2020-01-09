import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["template", "templatePlaceholder"]

  addBenefits(event) {
    event.preventDefault()
    const selectedBenefits = Array.from(document.querySelectorAll('#benefits option:checked'))
    const benefitHTML = selectedBenefits.map(benefit => {
      return this.templateTarget.innerHTML
        .replace(/TEMPLATE_RECORD/g, new Date().valueOf())
        .replace(/BENEFIT_ID/g, benefit.value)
        .replace(/BENEFIT_NAME/g, benefit.textContent)
    })
    this.templatePlaceholderTarget.insertAdjacentHTML('beforebegin', benefitHTML.join(' '))
  }
}
