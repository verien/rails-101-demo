Rails.application.routes.draw do

  resources :groups

  # root 'Controller#Action'
  root 'welcome#index'
  # welcome#index表示，首頁會使用welcome這個控制器的index行為。

end
