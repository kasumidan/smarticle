Rails.application.routes.draw do
  resources :smarticle_articles, shallow: true do
    resources :smarticle_sections
    resources :smarticle_pictures, only: [:create, :destroy, :new]
    resources :smarticle_videos, only: [:create, :destroy, :new]
    post '/smarticle_sections/orders', to: 'smarticle_sections#sort'
  end
  post '/smarticle_sectons/:id/cancel_edit', to: 'smarticle_sections#cancel_edit', as: :cancel_section_edit

end
