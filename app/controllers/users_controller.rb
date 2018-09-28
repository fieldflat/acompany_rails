class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order('created_at DESC').page(params[:page])
    #render 'show(アクション名)'が略されている.
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    # @user.saveでデータが保存される(コンソールで実行するときも同じだよね).
    if @user.save
      log_in(@user) #これを書かないと:idが付与されないため, これを書きましょう.
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
      # redirect_to @userは,
      # redirect_to user_url(@user)と同義である. (@userにはidの意味合いが含まれる)
      # さらに, redirect_to "/users/#{@user.id}"と同義である.
      # (参考) user GET  /users/:id(.:format)      users#show  (rails routesの実行一部分)より
      # (prefix)_url( ... ) の形.
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
  end

  def favorites
    @user =  User.find(params[:id])
    @favorites = @user.favs.page(params[:page])
  end


  private

  # new.html.erbから送信されてきた(POSTされてきた)データは, paramsに格納されている.
  # params内にはアクション名やコントローラ名, 「user」情報が格納されている.
  # 今回はその中から「:user」情報を取り出し(requireメソッド), 許可したいパラメータ(:name, :email, ...)
  # のみを取り出している.

  #疑問その2：password_confirmationの仕組み
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end
