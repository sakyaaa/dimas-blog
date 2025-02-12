# frozen_string_literal: true

# articles controller
class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    redirect_to root_path unless user_signed_in?

    @article = Article.new
  end

  def create
    return unless user_signed_in?

    @article = Article.new(article_params)
    @article.user_id = current_user.id

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])

    redirect_to @article unless current_user == @article.user
  end

  def update
    @article = Article.find(params[:id])

    return unless current_user == @article.user

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])

    return unless current_user == @article.user

    @article.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end
