class AddArticleTypeToSmartilceArticles < ActiveRecord::Migration
  def change
    add_column :smarticle_articles, :article_type, :text
  end
end
