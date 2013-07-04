Mirraw::Application.routes.draw do

  get 'parse', :to => "home#parse"
  root :to => "home#index"
  
end
