class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ email: params["email"] })
    if @user
      if BCrypt::Password.new(@user.password) == params["password"]
        session[:user_id] = @user.id
        flash[:notice] = "Welcome, #{@user.username}."
        redirect_to "/places"
      else
        flash[:notice] = "Incorrect Password"
        redirect_to "/sessions/new"
      end
    else
      flash[:notice] = "Email has not been registered"
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have logged out"
    redirect_to "/sessions/new"
  end
end
  