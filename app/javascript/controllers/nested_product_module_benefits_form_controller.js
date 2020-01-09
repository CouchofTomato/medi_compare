import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["template", "templatePlaceholder"]

  add_benefits(event) {
    event.preventDefault()
    const selectedBenefits = Array.from(document.querySelectorAll('#benefits option:checked'))
    const benefitSelection = selectedBenefits.map(benefit => {
      return {benefit_id: benefit.value, name: benefit.textContent}
    })
    const benefitHTML = benefitSelection.map(benefit => {
      let content = this.templateTarget.innerHTML
        .replace(/TEMPLATE_RECORD/g, new Date().valueOf())
        .replace(/BENEFIT_ID/g, benefit.benefit_id)
        .replace(/BENEFIT_NAME/g, benefit.name)
      return content
    })
    this.templatePlaceholderTarget.insertAdjacentHTML('beforebegin', benefitHTML.join(' '))
  }
}
