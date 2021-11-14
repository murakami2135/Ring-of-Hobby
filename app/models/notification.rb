class Notification < ApplicationRecord
  has_many :users
  # belongs_to :chat
  belongs_to :group, class_name: "Group", foreign_key: :chat_id
end
