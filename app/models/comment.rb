class Comment < ApplicationRecord
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"
  belongs_to :user
  belongs_to :task, dependent: :destroy

  validates :body, presence: true
end
