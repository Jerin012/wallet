Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"



  get "up" => "rails/health#show", as: :rails_health_check

  root "dashboard#index"

  get  "budget/new",    to: "budgets#new",    as: "new_budget"
  post "budget",        to: "budgets#create", as: "budget"
  get  "budget/edit",   to: "budgets#edit",   as: "edit_budget"
  patch "budget",       to: "budgets#update"

  post   "expenses",        to: "expenses#create", as: "expenses"
  delete "expenses/:id",    to: "expenses#destroy", as: "expense"

  post   "marked_dates",    to: "marked_dates#create", as: "marked_dates"
  delete "marked_dates/:id",to: "marked_dates#destroy", as: "marked_date"

  get "daily",   to: "dashboard#daily"
  get "monthly", to: "dashboard#monthly"
  get "savings", to: "dashboard#savings"
end


