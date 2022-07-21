Rails.application.routes.draw do
  devise_scope :user do
    # Redirests signing out users back to sign-in
    get "users", to: "devise/sessions#new"
  end
  devise_for :users

  root 'website#index'

  namespace :admin do
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
