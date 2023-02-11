Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, :skip => :sessions
    resources :missions
    resources :images
  end

end
