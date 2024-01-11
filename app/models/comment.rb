class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :task, dependent: :destroy

  validates :body, presence: true
end
