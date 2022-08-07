class ApplicationController < ActionController::Base
  # configure_permitted_parametersはDeviseコントローラーの場合だけ実行
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search

  protected
  def configure_permitted_parameters
    # サインアップ時にusernameも追加で許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:user_name])
    #プロフィール編集時にnameと自己紹介、アイコン画像のストロングパラメーターを渡す設定
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, :introduce, :user_image])
  end

  #新規ログイン後のリダイレクト先の変更()
  def after_sign_in_path_for(resource)
    root_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path(resource)
  end

  def search
    @q = Room.ransack(params[:q])
    @rooms = @q.result(distinct: true).recent
  end

end




