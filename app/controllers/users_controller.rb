class UsersController < ApplicationController

  # Code for Sign Up page here
  get '/signup' do
    if !logged_in?
      # display the user signup form
      erb :'users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    # create the user, save it to database
    # log the user in
    # add the user_id to the sessions hash
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end


  # Login code
  # does not let user view login page if already logged in (see lines 12 and 13)

  get "/login" do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/login'
    end   
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to '/signup'
    end
  end


  # Logout code
    # lets a user logout if they are already logged in and redirects to the login page
    # redirects a user to the index page if the user tries to access /logout while not logged in
    # redirects a user to the login route if a user tries to access /tweets route if user not logged in
    # loads /tweets if user is logged in

  get "/logout" do
    if logged_in?
      session.clear
      redirect "/login"      
    else
      redirect "/"
    end  
  end


  # user show page
  #   shows all a single users tweets
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/index' 
  end 

  
  get '/user' do
    @users = User.all
    erb:'tweets/index'
  end

  get '/tweet/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'tweets/show'
  end


end
