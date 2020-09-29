class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update show destroy]
  before_action :require_user, except: %i[index show]
  before_action :require_same_user, only: %i[edit update destroy]

  def new
    @comment = Comment.new
  end

  def index
    @comments = Comment.paginate(page: params[:page], per_page: 5)
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      flash[:success] = 'Article was successfully updated'
      redirect_to article_path(@comment.article)
    else
      render 'edit'
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.article_id = params[:article_id]
    if @comment.save
      flash[:success] = 'Comment was created'
      redirect_to article_path(@comment.article)
    else
      redirect_to articles_path
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
    params.require(:comment).permit(:description, :article_id)
  end

  def require_same_user
    if current_user != @comment.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own comments"
      redirect_to root_path
    end
  end
end
