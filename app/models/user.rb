class User < ActiveRecord::Base
  has_secure_password
  before_create :generate_api_key

  has_many :projects, dependent: :destroy
  has_many :discussions, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_many :tasks, dependent: :nullify


  has_many :favourites, dependent: :destroy
  has_many :favourite_projects, through: :favourites, source: :project

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # temporarily store password in memory
  # attr_accessor :password
  # attr_accessor :password_confirmation
  # add ^^ attributes for us.

  validate :password_length
  validates :password, length: { minimum: 5 }, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
            uniqueness: true,
            format: VALID_EMAIL_REGEX, unless: :from_oauth?

  # def authenticate_password(params)
  #   self.authenticate(user_params[:current_password])) && (user_params[:password] == user_params[:password_confirmation])
  # end
  # def update_password(params)
#
  # end

  def from_oauth?
    provider.present? && uid.present?
  end

  def full_name
    "#{first_name} #{last_name}".titleize.strip
  end

  def self.find_twitter_user(omniauth_data)
    where(provider: "twitter", uid: omniauth_data["uid"]).first
  end

  def self.create_from_twitter(twitter_data)
    name = twitter_data["info"]["name"].split(" ")
    User.create(provider: "twitter",
                uid: twitter_data["uid"],
                first_name: name[0], last_name: name[1],
                password: SecureRandom.hex,
                twitter_token: twitter_data["credentials"]["token"],
                twitter_secret: twitter_data["credentials"]["secret"],
                twitter_raw_data: twitter_data )
  end

  def self.find_github_user(omniauth_data)
    where(provider: "github", uid: omniauth_data["uid"]).first
  end

  def self.create_from_github(github_data)
    name = github_data["info"]["name"].split(" ")
    User.create(provider: "github",
                uid: github_data["uid"],
                first_name: name[0], last_name: name[1],
                password: SecureRandom.hex,
                github_token: github_data["credentials"]["token"],
                github_extra_data: github_data["extra"]["raw_info"])
  end

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

    def generate_api_key
      self.api_key = SecureRandom.hex(32)
      while User.exists?(api_key: self.api_key)
        self.api_key = SecureRandom.hex(32)
      end
    end

end
