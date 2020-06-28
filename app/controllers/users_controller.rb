class UsersController < ApplicationController

  get '/user' do
    @users = User.all
    erb:'tweets/index'
  end

  get '/tweet/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'tweets/show'
  end

end
