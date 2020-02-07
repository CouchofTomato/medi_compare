import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ["insurer", "product", "productModules"]

  getProducts(event) {
    this.productTarget.length = 1
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

  getProductModules(event) {
    this.productModulesTarget.innerHTML = ''
    if (this.productTarget.value == '') return

    Rails.ajax({
      url: `/products/${this.productTarget.value}/product_modules`,
      type: 'get',
      data: '',
      success: (data) => {
      },
      error: (data) => {
      }
    })
  }
}
