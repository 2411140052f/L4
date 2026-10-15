class TopController < ApplicationController
  def main
    if session[:login_uid].nil?
      render :login
    else
      render :main
    end
  end

  def login
    if User.exists?(uid: params[:uid], pass: params[:pass])
      session[:login_uid] = params[:uid]
      redirect_to top_main_path
    else
      @login_error = "ログイン失敗"
      render :login
    end
  end

  def logout
    session.delete(:login_uid)
    redirect_to top_main_path
  end
end