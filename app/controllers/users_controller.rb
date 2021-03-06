class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :favorites]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = '会員情報は正常に変更されました'
      redirect_to @user
    else
      flash.now[:danger] = '会員情報の変更に失敗しました'
      render :edit
    end
  end
  
  def favorites
    @user = User.find(params[:id])
    @favorites = @user.likes.page(params[:page]).per(5)
    counts(@user)
  end
  
  def reviews
    @user = User.find(params[:id])
    @reviews = @user.coments.page(params[:page]).per(5)
    counts(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:image, :name, :email, :password, :password_confirmation)
  end
  
  def correct_user
    @user = User.find_by(id: params[:id])
    if @user == nil || current_user.id != @user.id 
      redirect_to root_path
    end
  end
end