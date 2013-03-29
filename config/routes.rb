Rottenpotatoes::Application.routes.draw do
  resources :movies do
  # map '/' to be a redirect to '/movies'
    member do
    get 'director'
  end
  end
  #match "movies/:id/director" =>"movies#director"
  root :to => redirect('/movies')
end
