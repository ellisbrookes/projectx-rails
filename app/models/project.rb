class Project < ApplicationRecord belongs_to :company belongs_to :team validates
:title, presence: true validates :description, presence: true validates
:start_date, presence: true validates :completion_date, presence: true end
