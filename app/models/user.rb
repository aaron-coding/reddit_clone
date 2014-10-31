# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token
  
  has_many(
    :subs,
    class_name: "Sub",
    foreign_key: :moderator_id,
    dependent: :destroy
  )
  
  has_many :posts, class_name: "User", foreign_key: :author_id
  
  def self.find_by_credentials(username, password)
    return if username.nil? || password.nil?
    user = User.find_by_username(username)
    return if user.nil?
    user.is_password?(password) ? user : nil
  end
  
  def generate_session_token
    SecureRandom.base64(16)
  end
  
  def reset_session_token!
    self.session_token = generate_session_token
    self.save
    self.session_token
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def password
    @password
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  private
  def ensure_session_token
    self.session_token ||= SecureRandom.base64(16)
  end
  
end
