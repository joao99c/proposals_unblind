# frozen_string_literal: true

Rails.application.routes.draw do
  get 'user_account', to: 'user_account#index'
  get 'user_account/profile', to: 'user_account#profile'
  post 'user_account/profile', to: 'user_account#save_profile'
  get 'user_account/notifications', to: 'user_account#notifications'
  post 'user_account/notifications', to: 'user_account#save_notifications'
  get 'user_account/password', to: 'user_account#password'
  post 'user_account/password', to: 'user_account#save_password'
  get 'user_account/delete', to: 'user_account#delete'
  post 'user_account/delete', to: 'user_account#save_delete'
  devise_scope :user do
    # Redirects signing out users back to sign-in
    get 'users', to: 'devise/sessions#new'
    get 'users/password/verify_email', to: 'users/passwords#verify_email'
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  scope :admin do
    get '/', to: 'home#index', as: 'backoffice_home'
  end
  root 'website#index'

  namespace :admin do
    resources :tags, only: [:create]

    resources :deals, only: %i[index new create destroy] do
      namespace :editor do
        get '/', to: 'editor#index'
        get 'preview', to: 'editor#preview'
        get 'fonts', to: 'editor#fonts'
        patch 'fonts', to: 'editor#update_fonts'

        resources 'deal_sections' do
          member do
            patch 'reorder'
          end
          resources :deal_section_items, except: %i[new show] do
            member do
              patch 'reorder'
            end
          end
        end
      end

      member do
        get 'step_1'
        post 'step_1'

        get 'review'

        %w[customer product].each do |type|
          get "step_1/search_#{type}", to: "deals#search_#{type}"
          get "step_1/choose_#{type}", to: "deals#choose_#{type}", as: "step_1_choose_#{type}"
          post "step_1/choose_#{type}", to: "deals#save_choose_#{type}"
          delete "step_1/choose_#{type}", to: "deals#delete_choose_#{type}"

          # Popup criar e editar
          put "step_1/update_#{type}", to: "deals#update_#{type}"
          post "step_1/new_#{type}", to: "deals#new_#{type}"
        end

        put 'step_1/update_dp', to: 'deals#update_dp'
      end
    end

    scope 'deals/:id' do
      get 'pdf/show' => 'pdf#show'
      get 'pdf/download' => 'pdf#download'

      scope 'step_1' do
        get '/', to: 'deals#step_1', as: 'deal_step_1'
        post '/', to: 'deals#save_step_1'

        # get '/customer'

        scope :customer do
          get '/', to: 'deal_customers#show', as: 'deal_customers'

          get '/new', to: 'deal_customers#new', as: 'new_deal_customer'
          post 'existing_user', to: 'deal_customers#save_existing_user', as: 'save_deal_existing_user'
          post 'new_user', to: 'deal_customers#save_new_user', as: 'save_deal_new_user'
        end

        scope :products do
          get '/', to: 'deal_products#index', as: 'deal_products'
          get '/new', to: 'deal_products#new', as: 'new_deal_product'
          post '/new', to: 'deal_products#create'

          delete '/:dp_id', to: 'deal_products#destroy', as: 'destroy_deal_product'
        end
      end

      get 'step_2', to: 'deals#step_2', as: 'deal_step_2'
      post 'step_2', to: 'deals#save_step_2'
    end
    ApplicationRecord.admin_resources.each do |admin_resource|
      resources admin_resource do
        admin_resource.s_to_model.show_lists.each do |list|
          resources list, only: %i[] do
            collection do
              match 'search' => "#{admin_resource}#search",
                    via: %i[get post],
                    as: :search,
                    defaults: { parent_model: admin_resource.classify, model: list.classify }

              match 'new' => "#{admin_resource}#new",
                    via: :get,
                    as: :new,
                    defaults: { parent_model: admin_resource.classify, model: list.classify }
            end
          end
        end
        collection do
          match 'search' => "#{admin_resource}#search", via: %i[get post], as: :search
        end
      end
    end
  end
end
