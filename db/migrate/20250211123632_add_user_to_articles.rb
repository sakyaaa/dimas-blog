# frozen_string_literal: true

# db migrate - add reference 'user' to articles
class AddUserToArticles < ActiveRecord::Migration[7.2]
  def change
    add_reference :articles, :user, null: false, foreign_key: true
  end
end
