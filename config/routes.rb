Rails.application.routes.draw do
  devise_for :users
  root "job_posts#index" # ルートページを募集一覧に設定

  resources :users, only: [:show, :edit, :update, :destroy] do # マイページ用
    member do
      get :show_manager  # 施工管理者用ページ
      get :show_worker   # 作業員用ページ
    end
  end

  resources :job_posts do # 作業員募集機能
    resources :job_applications, only: [:create, :destroy] # 応募処理は job_post にネスト
  end
end
