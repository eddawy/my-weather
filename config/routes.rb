Rails.application.routes.draw do
  post '/show', to: 'weather#show', :defaults => { :format => 'json' }

  root 'weather#new'
end
