require './config/environment'

class ApplicationController < Sinatra::Base

  register Sinatra::ActiveRecordExtension

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "password_security"
	end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end


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
      redirect to '/tweets'
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
    erb :'/users/show' 
  end 

# index action
  #   logged in
  #     lets a user view the tweets index if logged in
  #   logged out
  #     does not let a user view the tweets index if not logged in
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
		else
			redirect "/login"
		end  
  end


# New action code


end