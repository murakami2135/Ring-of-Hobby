class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :chats
  # accepts_nested_attributes_for :group_users
  # belongs_to :home

  # has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  # has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy


  attachment :image

  def self.search(keyword)
    where(["name like?", "%#{keyword}%"])
  end

  validates :name, presence: true, uniqueness: true
end
