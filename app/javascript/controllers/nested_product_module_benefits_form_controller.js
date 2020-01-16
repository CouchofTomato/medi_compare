import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["template", "templatePlaceholder"]

  addBenefits(event) {
    event.preventDefault()
    const benefitSelect = document.getElementById('benefits')
    const selectedBenefits = Array.from(benefitSelect.selectedOptions)
    const benefitHTML = this.generateTemplateHTML(selectedBenefits)
    this.templatePlaceholderTarget.insertAdjacentHTML('beforebegin', benefitHTML)
    this.disableSelectedBenefits(benefitSelect, selectedBenefits)
    benefitSelect.selectedIndex = -1
  }

  generateTemplateHTML(benefits) {
    return benefits.map(benefit => {
      return this.templateTarget.innerHTML
        .replace(/TEMPLATE_RECORD/g, new Date().valueOf())
        .replace(/BENEFIT_ID/g, benefit.value)
        .replace(/BENEFIT_NAME/g, benefit.textContent)
    }).join(' ')
  }

  disableSelectedBenefits(benefitSelect, selectedBenefits) {
    const selectedBenefitIds = selectedBenefits.map(benefit => benefit.value)
    for(let i = 0; i < benefitSelect.length; i++) {
      if(selectedBenefitIds.includes(benefitSelect[i].value)) {
        benefitSelect[i].disabled = true
      }
    }
  }
}
