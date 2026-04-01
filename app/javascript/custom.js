import "@hotwired/turbo-rails"  // Turboを読み込む（不要なら削除可）

// price関数に処理をまとめる
const price = () => {
  const priceInput = document.getElementById("item-price")
  const taxDom = document.getElementById("add-tax-price")
  const profitDom = document.getElementById("profit")

  // 必要な要素がない場合は何もしない
  if (!priceInput || !taxDom || !profitDom) return

  // 二重登録防止
  if (priceInput.dataset.listenerAdded) return
  priceInput.dataset.listenerAdded = true

  // 入力イベント
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

// Turbo対応：ページロードと部分更新で呼ぶ
window.addEventListener("turbo:load", price)
window.addEventListener("turbo:render", price)