class Item < ApplicationRecord
  has_many :invoice
  belongs_to :company
end
