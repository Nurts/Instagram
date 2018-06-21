class Post < ApplicationRecord
    validates :body, length: {maximum: 255}
    validates :user_id, presence: true
    belongs_to :user
    has_one_attached :image
    has_many :likes
    default_scope -> {
        order "created_at DESC"
    }

    def liked?
        if signed_in?
            likes.where(user_id: current_user.id).count > 0
        end
    end
end
