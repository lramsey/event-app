class Event < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :details, presence: true, length: { maximum: 50 }
  validates :where,   presence: true, length: { maximum: 30}
  validates :start,   presence: true, date: { on_or_after: Date.current }
  validates :finish,  presence: true, date: { on_or_after: :start }
  validates :user_id, presence: true
end