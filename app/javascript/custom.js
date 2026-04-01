document.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price")
  const taxDom = document.getElementById("add-tax-price")
  const profitDom = document.getElementById("profit")

  if (!priceInput || !taxDom || !profitDom) return

  priceInput.addEventListener("input", () => {
    const price = parseInt(priceInput.value, 10)
    if (isNaN(price) || price <= 0) {
      taxDom.textContent = ""
      profitDom.textContent = ""
      return
    }

    const tax = Math.floor(price * 0.1)
    const profit = price - tax

    taxDom.textContent = tax.toLocaleString()
    profitDom.textContent = profit.toLocaleString()
  })
})