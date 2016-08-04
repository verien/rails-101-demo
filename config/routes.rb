Rails.application.routes.draw do

  devise_for :users
  # root 'Controller#Action'
  # welcome#index表示，首頁會使用welcome這個控制器的index行為。
  root 'welcome#index'

  # 因為我們最後目的是想要建立 http://localhost:3000/groups/1/posts/2 這樣的雙層網址。這樣的網址在 Rails 是屬於「巢狀」機制。
  resources :groups do
    resources :posts
  end

end
