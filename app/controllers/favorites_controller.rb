class FavoritesController < ApplicationController

  before_action :require_user_logged_in

  def create
    tweet = Tweet.find(params[:tweet_id])
    tweet.fav(current_user)
    flash[:success] = 'お気に入りしました。'
    redirect_to current_user
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    tweet.unfav(current_user)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_to current_user
  end
end
