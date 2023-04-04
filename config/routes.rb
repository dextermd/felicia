Rails.application.routes.draw do
  # http://127.0.0.1:3000//rails/info/routes

  resource :session, only: %i[new create destroy] # Убрали s  в конце  для того чтобы от нас не требовали id в маршруте

  resources :users, only: %i[new create]

  resources :questions do
    resources :answers, except: %i[new show] # except это кроме тек которые мы укажем # делаем это в :questions так как :questions содержат в себе :answers
  end

=begin
  resources :questions, only: %i[index new edit create update destroy show]
=end

=begin
  get '/questions', to: 'questions#index'
  get '/questions/new', to: 'questions#new'
  get '/questions/:id/edit', to: 'questions#edit'
  post '/questions', to: 'questions#create'
=end

  root "pages#index"
end
