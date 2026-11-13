class ArticlesController < ApplicationController
  # 投稿一覧画面
  def index
    @articles = Article.all
  end

  # 新規投稿画面
  def new
    @article = Article.new
  end

  # 投稿詳細画面
  def show
    @article = Article.find(params[:id])
  end

  # 投稿の保存処理
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path, notice: "新規投稿しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 編集画面の表示
  def edit
    @article = Article.find(params[:id])
  end

  # 更新処理
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article), notice: "更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, notice: "削除しました。", status: :see_other
  end

  private

  # ストロングパラメータ（安全にデータを受け取る仕組み）
  def article_params
    params.require(:article).permit(:title, :content)
  end
end