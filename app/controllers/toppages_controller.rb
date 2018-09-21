class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @tweet = current_user.tweets.build  # form_for 用 (buildで一つのオブジェクトを作成する.)
      @tweets = current_user.tweets.order('created_at DESC').page(params[:page])
    end

  end
end
