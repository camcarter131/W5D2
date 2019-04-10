class SessionsController < ApplicationController
  # def new

  # end
  
  def create 
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login(@user)
      redirect_to request.referrer
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to request.referrer
    end
  end

  def destroy 
    logout
    redirect_to subs_url
  end
  
end
