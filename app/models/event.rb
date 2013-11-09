class Event < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :details,     presence: true, length: { maximum: 140 }
  validates :where,       presence: true, length: { maximum: 25}
  validates_date :start,  presence: true, on_or_after: Date.current
  validates_date :finish, presence: true, on_or_after: :start
  validates :user_id,     presence: true
end
