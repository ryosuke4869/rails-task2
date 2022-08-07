# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  #(https://github.com/heartcombo/devise/blob/main/app/controllers/devise/sessions_controller.rb)
  #上記のURLからDevise::SessionsControllerのデフォルト設定をコピー

  # def create
  #   super
  # end

  def failed
    flash[:alert] = "メールアドレスまたはパスワード、ユーザー名が違います"
    redirect_to new_user_session_path
  end

  protected

  def auth_options
  { scope: resource_name, recall: "#{controller_path}#failed" } #racall先をnewからfailedに変更
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
