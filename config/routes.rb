Rails.application.routes.draw do
  post 'set_locale', to: 'currency#set_locale'
  get 'currency/convert', to: 'currency#convert'
  root 'currency#convert' # Set the root path
end
