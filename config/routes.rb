Rails.application.routes.draw do
  resources :inventories do
    collection { get :on_hand }
    collection { get :in_transit }
    collection { post :import_on_hand }
    collection { post :import_in_transit }
  end
  resources :products do
    collection { post :import }
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
