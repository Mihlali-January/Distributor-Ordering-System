import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "grandTotal" ]

  connect() {
    console.log("Order calculator connected")
  }

  recalculateRow(event) {
    const input = event.target
    const row = input.closest(".sku-row")
    const price = parseFloat(row.dataset.skuPrice)
    const pallets = parseInt(input.value) || 0
    
    // 1 pallet = 4800 units
    const unitsPerPallet = 4800
    const totalUnits = pallets * unitsPerPallet
    const lineCost = totalUnits * price

    // Update Row UI
    row.querySelector(".unit-total").textContent = totalUnits.toLocaleString()
    row.querySelector(".row-cost").textContent = lineCost.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })

    this.recalculateGrandTotal()
  }

  recalculateGrandTotal() {
    let grandTotal = 0
    
    this.element.querySelectorAll(".sku-row").forEach((row) => {
      const price = parseFloat(row.dataset.skuPrice)
      const input = row.querySelector(".pallet-input")
      const pallets = parseInt(input.value) || 0
      
      grandTotal += (pallets * 4800 * price)
    })

    this.grandTotalTarget.textContent = grandTotal.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })
  }
}
