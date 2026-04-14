const pay = () => {
  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();
  
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');

  form.addEventListener("submit", (e) => {
    e.preventDefault(); // まずは通常の送信を止める

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        // エラー（入力不備など）がある場合は何もしない（またはエラー表示）
        // Rails側のバリデーションに任せる場合はそのまま送信しても良いですが、
        // 基本はここで処理を止めるのが安全です。
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        // トークンをhiddenで追加（name属性を address_form[token] に合わせるのが一般的）
        const tokenObj = `<input value=${token} name='address_form[token]' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      
      // 入力フィールドをクリアにする前に送信を実行
      // clear()は送信後に画面が残る場合のみでOK。リダイレクトするなら不要です。
      form.submit();
    });
  });
};

// Turbo環境での多重読み込み防止策
window.addEventListener("turbo:load", pay);
// render時は、要素が既にある場合は再マウントしない等の制御が必要な場合がありますが、
// 基本はこの形で作動します。