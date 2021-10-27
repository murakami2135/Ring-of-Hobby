class Group < ApplicationRecord
  has_many :group_users
  #                ↓ここ何をやってるの？
  has_many :users, through: :group_users
  # ↓ここ何をやってるの？
  validates :name, presence: true, uniqueness: true
end
