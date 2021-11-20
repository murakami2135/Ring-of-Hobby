# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :chat_id
      t.boolean :checked
      t.timestamps
    end
  end
end
