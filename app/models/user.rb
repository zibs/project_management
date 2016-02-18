class User < ActiveRecord::Base
  has_secure_password
  has_many :projects, dependent: :destroy
  validate :password_length

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # temporarily store password in memory
  # attr_accessor :password
  # attr_accessor :password_confirmation
  # add ^^ attributes for us.

  validates :password, length: { minimum: 5 }, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
            uniqueness: true,
            format: VALID_EMAIL_REGEX

  # def authenticate_password(params)
  #   self.authenticate(user_params[:current_password])) && (user_params[:password] == user_params[:password_confirmation])
  # end
  # def update_password(params)
#
  # end

  private

  def password_length
    if password.present?
      true unless password.length <= 6
    elsif !password.present?
      true
    else
      errors.add(:password, "must be longer than 6 characters")
      # false
      # use false if doing a before_update callback
    end
  end

end
