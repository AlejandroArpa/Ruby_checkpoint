class Post < ApplicationRecord
  before_create :set_default_state
  belongs_to :user
  has_many :comments
  validates :title, presence: true
  validates :body, presence: true
  enum category: { poetry: 0, scifi: 1, mistery: 2, horror: 3, romance: 4 }

  # Scope
  scope :yours_posts, ->(user) { where(user_id: user.id) }
  scope :added_in_last_30_days, -> { where("created_at >= ? AND state = ?", 30.days.ago, true) }
  scope :post_availables, -> { where("state = ?", true) }

  private

  def set_default_state
    self.state ||= false
  end
end
