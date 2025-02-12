# frozen_string_literal: true

# db migration for article model
class CreateArticles < ActiveRecord::Migration[7.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.text   :body

      t.timestamps
    end
  end
end
