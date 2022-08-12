# frozen_string_literal: true

Rails.application.routes.draw do
  devise_scope :user do
    # Redirests signing out users back to sign-in
    get 'users', to: 'devise/sessions#new'
  end
  devise_for :users

  scope :admin do
    get '/', to: 'home#index', as: 'backoffice_home'
  end
  root 'website#index'

  namespace :admin do
    resources :tags, only: [:create]

    resources :deals, only: [:index, :new, :create] do
      namespace :editor do
        get '/', to: 'editor#index'
        get 'preview', to: 'editor#preview'
        get 'sections', to: 'editor#sections'

        resources "deal_sections" do
          member do
            get 'confirm_destroy'
            patch 'reorder'
          end
          resources :deal_section_items, except: [:new, :show] do
            member do
              patch 'reorder'
            end
          end
        end
      end

      resources :deal_customers, only: [:show, :new] do
        collection do
          post 'save_existing_user'
          post 'save_new_user'
        end
      end

      resources :deal_products, only: [:index, :new, :create, :destroy]

      member do
        get 'step_1'
        post 'step_1'
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
