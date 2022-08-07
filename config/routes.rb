Rails.application.routes.draw do
  get "homes/index"
  root "homes#index" #アクセスしたらhome画面に

  #検索機能のroute
  resources :rooms do
    collection do
      get "search"
    end
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  get "users/update" => "users#update"
  get 'users/registrations/edit'
  get 'users/profile' => 'users#profile'

  resources :rooms

  #roomsリソースにはログイン後でないとアクセスできない。
  #ログイン前にアクセスするとroot_pathにリダイレクト
  authenticate do
    resources :rooms
  end

  # デフォルトで有効なpasswords、registrations、sessionsの3つを指定

  #reservationのroutes
  resources :reservations, only:[:new,:index]
  get '/reservations' => 'reservations#index'
  get 'reservations/confirm' # 確認画面
  post 'reservations/confirm' # 確認画面
  post 'reservations/back' # 確認画面から「入力画面に戻る」をクリックしたとき
  post "/reservations" => "reservations#create"
  get'reservations/complete' # 完了画面






  #どのroomsに対してのreservationsであるかをルーティングで紐づけ
  resources :rooms do
    resources :reservations
  end
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
