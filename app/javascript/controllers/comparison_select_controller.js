import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ["insurer", "product"]

  getProducts(event) {
    this.clearSelect(this.productTarget)
    Rails.ajax({
      url: `/insurers/${this.insurerTarget.value}/products.json`,
      type: 'get',
      data: '',
      success: (data) => {
        this.addProducts(data)
      },
      error: (data) => {
        console.log(data)
      }
    })
  }

  clearSelect(target) {
    target.length = 1
  }

  addProducts(products) {
    products.forEach(product => {
      const option = document.createElement('option')
      option.value = product.id
      option.text = product.name
      this.productTarget.appendChild(option)
    })
  }
}
