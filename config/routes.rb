Rails.application.routes.draw do
  post 'vehicles/scrape', to: 'vehicles#scrape'
  get 'vehicles', to: 'vehicles#vehicles'
  get 'tasks', to: 'vehicles#tasks'
  delete 'destroy_task', to: 'vehicles#destroy_task'
end
