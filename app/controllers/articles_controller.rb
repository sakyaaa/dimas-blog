# frozen_string_literal: true

# articles controller
class ArticlesController < ApplicationController
  def index
    authorize Article

    @articles = if params[:query].present?
                  search_articles(policy_scope(Article), params[:query])
                else
                  policy_scope(Article)
                end
  end

  def show
    authorize Article

    @article = policy_scope(Article).find(params[:id])
  end

  def new
    authorize Article

    @article = Article.new
  end

  def create
    authorize Article

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

    authorize @article
  end

  def update
    @article = Article.find(params[:id])

    authorize @article

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])

    authorize @article

    @article.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end

  def search_articles(scope, query)
    query = query.downcase
    articles_table = Article.arel_table

    scope.where(
      articles_table[:title].lower.matches("%#{query}%")
        .or(articles_table[:body].lower.matches("%#{query}%"))
    )
  end
end
