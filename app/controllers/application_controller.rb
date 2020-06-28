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
    # does not let user view login page if already logged in (FAILED - 10)

# Logout code
    # lets a user logout if they are already logged in and redirects to the login page (FAILED - 11)
    # redirects a user to the index page if the user tries to access /logout while not logged in (FAILED - 12)
    # redirects a user to the login route if a user tries to access /tweets route if user not logged in (FAILED - 13)
    # loads /tweets if user is logged in (FAILED - 14)



# user show page
  #   shows all a single users tweets (FAILED - 15)


# index action
  #   logged in
  #     lets a user view the tweets index if logged in (FAILED - 16)
  #   logged out
  #     does not let a user view the tweets index if not logged in (FAILED - 17)



# New action code


end