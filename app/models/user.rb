class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token, :reset_token
    before_create :create_activation_digest
    before_save {self.email = email.downcase
        self.username = username.downcase}

    has_secure_password
    has_one_attached :avatar
    has_many :posts
    has_many :likes
    has_many :relationships, foreign_key: :followed_id, dependent: :destroy
    has_many :followers, through: :relationships
    has_many :reverse_relationships, foreign_key: :follower_id, class_name: "Relationship"
    has_many :following, through: :reverse_relationships, source: :followed

    validates_presence_of :email, :username
    validates_uniqueness_of :email, :username
    validates :password, length: {minimum: 6, maximum: 30}, allow_nil: true
    validates_email_format_of :email, message: 'The email format is not correct!'
    validates :username, format: { with: /\A[0-9a-zA-Z_.\-]+\Z/, message: "Only alphanumeric characters, and -_."}
    validates :username, length: {maximum: 30}

    class << self
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end

        def new_token
            SecureRandom.urlsafe_base64
        end
    end
    
    def remember
        @remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end
    
    def forget
        update_attribute(:remember_digest, nil)
    end

    def create_reset_digest
        self.reset_token = User.new_token
        update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
    end

    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    def follow(user)
        reverse_relationships.create(followed_id: user.id) unless following?(user)
    end

    def unfollow(user)
        reverse_relationships.where(followed_id: user.id).first.destroy if following?(user)
    end

    def following?(user)
        reverse_relationships.where(followed_id: user.id).count > 0
    end

    def feed
        Post.where(user_id: following_ids)
    end


    private

    def create_activation_digest
        self.activation_token = User.new_token
        self.activation_digest = User.digest(activation_token)
    end
end
