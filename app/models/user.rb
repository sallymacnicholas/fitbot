class User < ActiveRecord::Base
  validates :uid, presence: true
  has_one :goal
  has_one :notification
  has_one :profile

  def self.find_or_create_from_oauth(oauth)
    user = User.find_or_create_by(provider: oauth.provider, uid: oauth.uid)
    user.username = oauth.info.full_name
    user.token = oauth.extra.access_token.params["oauth_token"]
    user.secret = oauth.extra.access_token.params["oauth_token_secret"]
    user.provider = oauth.provider
    user.uid = oauth.uid
    user.save
    user
  end
end
