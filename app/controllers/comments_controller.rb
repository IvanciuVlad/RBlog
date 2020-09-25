class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def index
    @comments = Comment.paginate(page: params[:page], per_page: 5)
  end

  def edit; end

  def update

  end

  def create
    @article = Article.find(params[:id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = 'Comment was created'
      redirect_to article_path(@article)
    else
      flash.now[:danger] = "Failed to post the comment"
    end

  end

  def destroy
    @comment.destroy
    flash[:danger] = 'Comment was deleted'
    redirect_to articles_path
  end

  def show; end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:description, article_id: [])
  end

  def require_same_user
    if current_user != @comment.user
      flash[:danger] = "You can only edit or delete your own comments"
      redirect_to root_path
    end
  end
end
