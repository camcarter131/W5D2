class SubsController < ApplicationController

before_action :require_login, only: [:edit, :new, :create, :update]
before_action :require_mod, only: [:edit, :update]

  def new 
    @sub = Sub.new
  end

  def create 
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index 
    @subs = Sub.all
  end 

  def show 
    @sub = Sub.find(params[:id])
    # debugger
  end
  
  def edit 
    @sub = Sub.find(params[:id])
  end
  
  def update 
    # debugger 
    @sub = Sub.find(params[:id])
    @sub.moderator_id = current_user.id
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
  
  def require_mod
    @sub = Sub.find(params[:id])
    redirect_to sub_url(@sub) unless current_user.id == @sub.moderator_id
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
