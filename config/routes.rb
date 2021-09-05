Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  
  root 'static_pages#home'   
  get '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/:username/blog/:title' => 'blogs#show', as: 'blog_post'
  # Request
    # <%= link_to "BLOG-TITLE", blog_post_path(:username => CGI.escape(blog.user.name).gsub('+','_'), :title => CGI.escape("BLOG-TITLE").gsub('+','_'), :blog_post_id => blog.id) %>
    # - blog.id is required to FIND the Blog Post in BlogsController/show Action.
  
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :blogs,          only: [:show, :create, :destroy ]    
  resources :relationships,       only: [:create, :destroy]
  


end
