// 不要な日本語の行を削除、またはコメントアウトしました
import "@hotwired/turbo-rails"

const price = () => {
  const priceInput = document.getElementById("item-price")
  const taxDom = document.getElementById("add-tax-price")
  const profitDom = document.getElementById("profit")

  if (!priceInput || !taxDom || !profitDom) return

  if (priceInput.dataset.listenerAdded) return
  priceInput.dataset.listenerAdded = true

  priceInput.addEventListener("input", () => {
    const priceValue = Number(priceInput.value)
    if (!priceValue || priceValue <= 0) {
      taxDom.textContent = ""
      profitDom.textContent = ""
      return
    }

    const tax = Math.floor(priceValue * 0.1)
    const profit = priceValue - tax

    taxDom.textContent = tax.toLocaleString()
    profitDom.textContent = profit.toLocaleString()
  })
}

window.addEventListener("turbo:load", price)