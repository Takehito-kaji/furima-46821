import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"   // Turbo を読み込む
import "./controllers"            // Stimulus コントローラ
import "./custom"                 // 自作JS

// ここで Rails UJS を読み込む
import Rails from "@rails/ujs"
Rails.start()

const application = Application.start()
application.debug = false
window.Stimulus = application

export { application }