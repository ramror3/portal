class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:show]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def show

  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was created successfully'}
        format.json { head :ok}
      else
        format.html { render action: 'new'}
        format.json { render json: @post.erros, status: :unporcessable_entity}
      end
    end
  end

 
  def edit
    
  end

  def update
    if @post.update(params[:post].permit(:title, :body))
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private
    def post_params
      params.require(:post).permit(:title, :description)
    end

    def find_post
      @post = Post.find(params[:id])
    end
end
