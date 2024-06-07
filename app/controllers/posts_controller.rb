class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def create
    @post = current_user.posts.build(post_params)

    result = Geocoder.search(@post.address).first
    if result
      @post.latitude = result.latitude
      @post.longitude = result.longitude
    end

    if  @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "編集が完了しました。"
      redirect_to post_path(@post.id)
    else
      flash[:alert] = "編集ができませんでした。"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def test
    
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :image, :address,)
    end
end
