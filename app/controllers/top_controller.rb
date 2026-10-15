class TopController < ApplicationController
  def main
    if session[:login_uid].nil?
      render :login
    else
      render :main
    end
  end

  def login
    if params[:uid] == "kindai" && params[:pass] == "sanriko"
      session[:login_uid] = params[:uid]
      redirect_to top_main_path
    else
      @login_error = "ログイン失敗"
      render :login
    end
  end
end