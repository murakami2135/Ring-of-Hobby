class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :chats
  belongs_to :home

  attachment :image

  def self.search(keyword)
    where(["name like?", "%#{keyword}%"])
  end

  validates :name, presence: true, uniqueness: true
end
