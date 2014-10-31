class SubsController < ApplicationController
  before_action :ensure_moderator, only: [:edit, :update]
  
  def new
    @sub = Sub.new
    render :new  
  end
  
  def index
    @subs = Sub.all
    render :index
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
  

  def show
    @sub = Sub.find(params[:id])
    render :show
  end
  
  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end
  
  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
  
  # def destroy
  #
  # end
  
  private
  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end
  
  def ensure_moderator    
    if current_user.nil? || (current_user.id != Sub.find(params[:id]).moderator_id)
      redirect_to sub_url(params[:id])
    end
  end
end
