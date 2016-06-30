class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_or_create_from_oauth(oauth)

    binding.pry
    if @user
      session[:user_id] = @user.id
      redirect_to dashboard_index_path
    else
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def oauth
    request.env['omniauth.auth']
  end
end
