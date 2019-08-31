Rails.application.routes.draw do
 resources :books
 get 'top' => 'home#top'
 get 'home/about'=> 'home#about'
 
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show,:index,:edit,:update]

  root 'home#top'

  resources :post_images, only: [:new, :create, :index, :show] do
    resource :post_comments, only: [:create, :destroy]

  get 'posts' => 'posts#index'

end
end
