class PostsController < ApplicationController
  before_action :ensure_author, only: [:edit, :update, :destroy]
  
  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end
  
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      @subs = Sub.all
      render :new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all    
    render :edit
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @subs = Sub.all
    render :show
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to subs_url
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
  
  def ensure_author    
    if current_user.nil? || (current_user.id != Post.find(params[:id]).author_id)
      redirect_to post_url(params[:id])
    end
  end
end
