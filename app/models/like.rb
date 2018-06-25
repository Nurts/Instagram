class Like < ApplicationRecord
    belongs_to :user
    belongs_to :post
=begin
    after_create :add_like
    before_destroy :

    private

    def add_like
        post.likes_count += 1
    end

    def 
=end
end
