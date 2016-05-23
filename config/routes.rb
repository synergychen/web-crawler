Rails.application.routes.draw do
  require 'sidekiq/web'

  namespace :image_tasks do
    get "fetch_image_uris"
    get "save_images"
  end

  mount Sidekiq::Web, at: '/sidekiq'
end
