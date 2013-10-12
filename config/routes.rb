LittleButton2::Application.routes.draw do
  get "/email_processor", to: proc { [200, {}, ["OK"]] }, as: "mandrill_head_test_request"

  root 'questions#index'


  # Sidekiq processes
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # User registration
  devise_for :users, :skip => [:sessions, :registration]
  as :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    get 'signup', to: 'devise/registrations#new', as: :new_user_registration
    post 'signup', to: 'devise/registrations#create', as: :user_registration
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  get 'confirm-email' => 'users#confirm_email', as: 'confirm_email'
  get 'company-from-email' => 'companies#company_from_email', as: 'company_from_email'

  # Questions & Answers
  resources :questions, only: [:index, :show, :create, :destroy, :update] do
    resources :answers, only: [:update, :destroy, :create]
  end

  # Settings
  scope '/settings' do
    get '', to: 'settings#index', as: 'settings'

    scope '/account' do
      get '', to: 'settings#account', as: 'settings_account'
      patch '',
            to: 'settings#settings_update_password',
            as: 'settings_update_password'
      patch 'update-name',
            to: 'settings#settings_update_name',
            as: 'settings_update_name'
    end

    scope '/admin' do
      get '', to: 'settings#admin', as: 'settings_admin'
      patch '', to: 'settings#update_company', as: 'update_company'
      patch 'update-collect-answers-schedule',
            to: 'settings#update_collect_answers_schedule',
            as: 'update_collect_answers_schedule'
      patch 'update-collect-questions-schedule',
            to: 'settings#update_collect_questions_schedule',
            as: 'update_collect_questions_schedule'
      patch 'update-email-answers-schedule',
            to: 'settings#update_email_answers_schedule',
            as: 'update_email_answers_schedule'
    end
  end

  # Incoming email processing
  # mount_griddler('/email/incoming')

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
