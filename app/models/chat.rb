class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :group
  # has_many :notifications
end
