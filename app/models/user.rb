class User < ApplicationRecord
    validates :email, :username, presence: true, uniqueness: { case_sensitive: false }
    has_secure_password
    has_many :articles
    has_many :comments
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

end