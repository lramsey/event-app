class Event < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :details, presence: true, length: { maximum: 50 }
  validates :where,   presence: true, length: { maximum: 30}
  validates :start,   presence: true, date: { on_or_after: Date.current }
  validates :finish,  presence: true, date: { on_or_after: :start }
  validates :user_id, presence: true

  # Returns events from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end