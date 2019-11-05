class User < ApplicationRecord
    before_create :confirmation_token

    validates :email, :username, presence: true, uniqueness: { case_sensitive: false }
    validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/ }
    validates :username, format: {with: /\A[a-zA-Z]+[a-zA-Z0-9'_.]*\z/ }

    validates :password,
        presence: true,
        length: {minimum: 6},
        confirmation: true,
        on: :create

    validates :password,
        allow_nil: true,
        length: {minimum: 6},
        confirmation: true,
        on: :update
    
    has_secure_password

    has_many :articles, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :friend_requests, dependent: :destroy
    has_many :pending_friends, through: :friend_requests, source: :friend

    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships
    has_and_belongs_to_many :groups, :join_table => :users_groups


    def except_current_user(users)
        users.reject { |user| user.id == self.id }
    end

    def self.search(param)
        param.strip!
        param.downcase!
        to_send_back = (username_matches(param)).uniq
        return nil unless to_send_back
        to_send_back
    end
      
    def self.username_matches(param)
        matches('username', param)
    end

    def self.matches(field_name, param)
        where("#{field_name} like ?", "%#{param}%")
    end

    def email_activate
        self.email_confirmed = true
        self.confirm_token = nil
        save!(:validate => false)
    end


private

    def confirmation_token
        if self.confirm_token.blank?
            self.confirm_token = SecureRandom.urlsafe_base64.to_s
        end
    end

end