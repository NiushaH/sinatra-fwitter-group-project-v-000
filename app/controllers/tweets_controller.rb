class TweetsController < ApplicationController


# index action
  #   logged in
  #     lets a user view the tweets index if logged in
  #   logged out
  #     does not let a user view the tweets index if not logged in
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end


  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect to "/tweets/new"
      else
        @tweet = current_user.tweets.build(content: params[:content])
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect to "/tweets/new"
        end
      end
    else
      redirect to '/login'
    end
  end

end