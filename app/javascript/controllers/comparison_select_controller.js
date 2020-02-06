import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ["insurer", "product"]

  getProducts(event) {
    this.clearSelect(this.productTarget)
    if (this.insurerTarget.value == '') return

    Rails.ajax({
      url: `/insurers/${this.insurerTarget.value}/products`,
      type: 'get',
      data: '',
      success: (data) => {
      },
      error: (data) => {
        console.log(data)
      }
    })
  }

  clearSelect(target) {
    target.length = 1
  }
}
