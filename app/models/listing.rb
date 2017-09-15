class Listing < ApplicationRecord
  validates :title, presence: true
  validates_uniqueness_of :title, scope: :issue_date
end
