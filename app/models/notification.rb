class Notification < ApplicationRecord
  belongs_to :user
  # belongs_to :chat
  belongs_to :group, class_name: "Group", foreign_key: :chat_id
end
