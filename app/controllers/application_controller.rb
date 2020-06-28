require './config/environment'

class ApplicationController < Sinatra::Base

  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

# Code for Sign Up page here



# Login code
  get "/login" do
    if logged_in?
			redirect "/tweets"
		else
      erb :login
		end   
	end

# Logout code





# New action code


end