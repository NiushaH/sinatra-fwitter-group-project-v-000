class TweetsController < ApplicationController


# index action
  #   logged in
  #     lets a user view the tweets index if logged in
  #   logged out
  #     does not let a user view the tweets index if not logged in
  get '/tweets' do
    if logged_in?
      # @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(:content => params[:content], :user_id => current_user.id)
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end

  # lets user view new tweet form if logged in
  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if !params[:content].empty?
        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect "/login"
    end
  end

  delete "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        @tweet.destroy
        redirect "/tweets"
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

end