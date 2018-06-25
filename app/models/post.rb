class Post < ApplicationRecord
    attr_accessor :likes_count
    validates :body, length: {maximum: 255}
    validates :user_id, presence: true
    belongs_to :user
    has_one_attached :image
    has_many :likes
    default_scope -> {
        order "created_at DESC"
    }

    def liked?(user_id)
        likes.where(user_id: user_id).count > 0
    end

end
