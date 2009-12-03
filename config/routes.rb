ActionController::Routing::Routes.draw do |map|
  map.resources :providers, :member => { :auto_complete_show => :get }, :collection => { :auto_complete => :get }

  map.resources :provider_types

  map.resources :patients do |patients|
    patients.resources :registrations, :collection => {:change_study => :get}
    patients.resources :patient_provider_assignments
  end

  map.root :controller => 'registrations', :action => 'index'

  map.logout 'logout', { :controller => 'access', :action => 'logout' }

  map.session_expiry 'session_expiry', { :controller => 'application', :action => 'session_expiry' }

  map.resources :patient_provider_assignments

  map.resources :registrations

  map.js ':controller/:action.:format'
end
