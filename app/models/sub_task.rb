class SubTask < ApplicationRecord
  belongs_to :task
  belongs_to :reporter, class_name: "User"
  belongs_to :assigned_to, class_name: "User"
  belongs_to :project
  belongs_to :team
end
