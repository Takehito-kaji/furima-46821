class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # サインアップ時
    devise_parameter_sanitizer.permit(:sign_up, keys: [
                                        :nickname, :email, :password, :last_name_kanji, :first_name_kanji,
                                        :last_name_kana, :first_name_kana, :birth_date
                                      ])

    # アカウント更新時
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password])
  end
end
