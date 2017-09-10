# == Route Map
#
#                            Prefix Verb   URI Pattern                             Controller#Action
#                     administrator GET    /administrator(.:format)                administrator#index
#                              home GET    /home(.:format)                         dashboard#home
#                         dashboard GET    /dashboard(.:format)                    dashboard#index
#                  new_user_session GET    /users/sign_in(.:format)                users/sessions#new
#                      user_session POST   /users/sign_in(.:format)                users/sessions#create
#              destroy_user_session DELETE /users/sign_out(.:format)               users/sessions#destroy
#                     user_password POST   /users/password(.:format)               devise/passwords#create
#                 new_user_password GET    /users/password/new(.:format)           devise/passwords#new
#                edit_user_password GET    /users/password/edit(.:format)          devise/passwords#edit
#                                   PATCH  /users/password(.:format)               devise/passwords#update
#                                   PUT    /users/password(.:format)               devise/passwords#update
#          cancel_user_registration GET    /users/cancel(.:format)                 users/registrations#cancel
#                 user_registration POST   /users(.:format)                        users/registrations#create
#             new_user_registration GET    /users/sign_up(.:format)                users/registrations#new
#            edit_user_registration GET    /users/edit(.:format)                   users/registrations#edit
#                                   PATCH  /users(.:format)                        users/registrations#update
#                                   PUT    /users(.:format)                        users/registrations#update
#                                   DELETE /users(.:format)                        users/registrations#destroy
#            accept_user_invitation GET    /users/invitation/accept(.:format)      users/invitations#edit
#            remove_user_invitation GET    /users/invitation/remove(.:format)      users/invitations#destroy
#                   user_invitation POST   /users/invitation(.:format)             users/invitations#create
#               new_user_invitation GET    /users/invitation/new(.:format)         users/invitations#new
#                                   PATCH  /users/invitation(.:format)             users/invitations#update
#                                   PUT    /users/invitation(.:format)             users/invitations#update
#                              root GET    /                                       welcome#index
#                   user_activities GET    /user_activities(.:format)              user_activities#index
#                          channels GET    /channels(.:format)                     channels#index
#                                   POST   /channels(.:format)                     channels#create
#                       new_channel GET    /channels/new(.:format)                 channels#new
#                      edit_channel GET    /channels/:id/edit(.:format)            channels#edit
#                           channel GET    /channels/:id(.:format)                 channels#show
#                                   PATCH  /channels/:id(.:format)                 channels#update
#                                   PUT    /channels/:id(.:format)                 channels#update
#                                   DELETE /channels/:id(.:format)                 channels#destroy
#               television_programs GET    /television_programs(.:format)          television_programs#index
#                                   POST   /television_programs(.:format)          television_programs#create
#            new_television_program GET    /television_programs/new(.:format)      television_programs#new
#           edit_television_program GET    /television_programs/:id/edit(.:format) television_programs#edit
#                television_program GET    /television_programs/:id(.:format)      television_programs#show
#                                   PATCH  /television_programs/:id(.:format)      television_programs#update
#                                   PUT    /television_programs/:id(.:format)      television_programs#update
#                                   DELETE /television_programs/:id(.:format)      television_programs#destroy
#                  ads_performances GET    /ads_performances(.:format)             ads_performances#index
#                                   POST   /ads_performances(.:format)             ads_performances#create
#               new_ads_performance GET    /ads_performances/new(.:format)         ads_performances#new
#              edit_ads_performance GET    /ads_performances/:id/edit(.:format)    ads_performances#edit
#                   ads_performance GET    /ads_performances/:id(.:format)         ads_performances#show
#                                   PATCH  /ads_performances/:id(.:format)         ads_performances#update
#                                   PUT    /ads_performances/:id(.:format)         ads_performances#update
#                                   DELETE /ads_performances/:id(.:format)         ads_performances#destroy
#                         post_buys GET    /post_buys(.:format)                    post_buys#index
#                                   POST   /post_buys(.:format)                    post_buys#create
#                      new_post_buy GET    /post_buys/new(.:format)                post_buys#new
#                     edit_post_buy GET    /post_buys/:id/edit(.:format)           post_buys#edit
#                          post_buy GET    /post_buys/:id(.:format)                post_buys#show
#                                   PATCH  /post_buys/:id(.:format)                post_buys#update
#                                   PUT    /post_buys/:id(.:format)                post_buys#update
#                                   DELETE /post_buys/:id(.:format)                post_buys#destroy
#                           viewers GET    /viewers(.:format)                      viewers#index
#                                   POST   /viewers(.:format)                      viewers#create
#                        new_viewer GET    /viewers/new(.:format)                  viewers#new
#                       edit_viewer GET    /viewers/:id/edit(.:format)             viewers#edit
#                            viewer GET    /viewers/:id(.:format)                  viewers#show
#                                   PATCH  /viewers/:id(.:format)                  viewers#update
#                                   PUT    /viewers/:id(.:format)                  viewers#update
#                                   DELETE /viewers/:id(.:format)                  viewers#destroy
# export_tables_administrator_index GET    /administrator/export_tables(.:format)  administrator#export_tables
#               administrator_index GET    /administrator(.:format)                administrator#index
#                                   POST   /administrator(.:format)                administrator#create
#                 new_administrator GET    /administrator/new(.:format)            administrator#new
#                edit_administrator GET    /administrator/:id/edit(.:format)       administrator#edit
#                                   PATCH  /administrator/:id(.:format)            administrator#update
#                                   PUT    /administrator/:id(.:format)            administrator#update
#                                   DELETE /administrator/:id(.:format)            administrator#destroy
# 

Rails.application.routes.draw do
  get 'administrator', to: 'administrator#index' 
  get 'home/', to: 'dashboard#home' 
  get 'dashboard/', to: 'dashboard#index' 
  devise_for :users, controllers: { 
    sessions: 'users/sessions', 
    registrations: 'users/registrations', 
    invitations: 'users/invitations'
  }
  root 'welcome#index'

  resources :user_activities, only: [:index]
  resources :channels
  resources :television_programs do
    collection do
      post :import
    end
  end
  resources :ads_performances
  resources :post_buys
  resources :viewers
  resources :administrator, except: [:show] do
    collection do
      get :export_tables
    end
  end
end
