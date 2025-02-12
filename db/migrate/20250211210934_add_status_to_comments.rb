# frozen_string_literal: true

# db migrate - add status column to comments
class AddStatusToComments < ActiveRecord::Migration[7.2]
  def change
    add_column :comments, :status, :string, default: 'public'
  end
end
