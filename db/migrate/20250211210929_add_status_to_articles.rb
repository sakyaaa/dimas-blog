# frozen_string_literal: true

# db migrate - add status column to articles
class AddStatusToArticles < ActiveRecord::Migration[7.2]
  def change
    add_column :articles, :status, :string, default: 'public'
  end
end
