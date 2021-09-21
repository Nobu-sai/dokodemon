class User < ApplicationRecord
    has_many :blogs, dependent: :destroy
    has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
    has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
    has_many :following, through: :active_relationships,  source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
    has_many :place_comments

    attr_accessor :remember_token, :activation_token, :reset_token
    before_save   :downcase_email
    before_create :create_activation_digest

    
  # Criteria for user enrollment
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: true
                        
    has_secure_password
    
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  
  class << self
    # Returns the hash digest of the given string.
      def digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
      end
    
    # Returns a random token.
      def new_token
        SecureRandom.urlsafe_base64
      end
  end
  
  #Actually save the user log in status
    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
      remember_digest
    end
    
  # Returns a session token to prevent session hijacking.
  # We reuse the remember digest for convenience.
    def session_token
      remember_digest || remember
    end
  
  # Check if the given token is METCHING to the DIGESTED token (saved in APP's database for each user)
  # For (As attribute Param)
  # - Activation
  # - Remember Cookies
    def authenticated?(attribute, token)
      digest = send("#{attribute}_digest")
      return false if digest.nil?
      BCrypt::Password.new(digest).is_password?(token)
    end
    
  # Forgets a user.
    def forget
      update_attribute(:remember_digest, nil)
    end
  
  # Activates an account.
    def activate
      update_columns(activated: true, activated_at: Time.zone.now)
    end

  # Sends activation email.
    def send_activation_email
      UserMailer.account_activation(self).deliver_now
    end

  # Sets the password reset attributes.
    def create_reset_digest
      self.reset_token = User.new_token
      update_columns(reset_digest:  User.digest(reset_token), reset_sent_at: Time.zone.now)
    end

  # Sends password reset email.
    def send_password_reset_email
      UserMailer.password_reset(self).deliver_now
    end
    
    def password_reset_expired?
      reset_sent_at < 2.hours.ago
    end
  
  # Set Query to get the user IDs who the currently LOGGED IN user is FOLLOWING 
    # How
    # => Get ALL the Relationships/followed_id or all the users have followers
    # =>> Compaire each of the FOLLOWERS with the id of the LOGGED IN user.
    # =>>> Store the Follower IDs MATCHING to the LOGGED IN user ID.
    def set_following_ids_query  
      following_ids = "SELECT followed_id FROM relationships
      WHERE  follower_id = :current_user_id"
    end        
  
  
  # Follows a user.
    def follow(other_user)
      following << other_user
    end

  # Unfollows a user.
    def unfollow(other_user)
      following.delete(other_user)
    end

  # Returns true if the current user is following the other user.
    def following?(other_user)
      following.include?(other_user)
    end
  
  
  private

    # Converts email to all lower-case.
    def downcase_email
      email.downcase!
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
  
  
end

