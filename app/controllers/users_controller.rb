class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
    @relationship = Relationship.where(user_id: current_user.id, follow_id: params[:id])
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
    @relationship = Relationship.where(user_id: current_user.id, follow_id: params[:id])
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
    @book = Book.new
  	@user = User.find(params[:id])
    @books = @user.books
  	if @user.update(user_params)
  		redirect_to user_path(@user), notice: "successfully updated user!"
  	else
  		render "show"
  	end
  end

  def following
    @relationship = Relationship.where(user_id: current_user.id, follow_id: params[:id])
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @relationship = Relationship.where(user_id: current_user.id, follow_id: params[:id])
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private

  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
      user = User.find(params[:id])
    if current_user != user
       redirect_to user_path(current_user)
    end
  end
end
