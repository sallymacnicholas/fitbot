class User < ActiveRecord::Base
  has_one :goal

  def self.find_or_create_from_oauth(oauth)
    user = User.find_or_create_by(provider: oauth.provider, uid: oauth.uid)
    user.username = oauth.info.full_name
    user.token = oauth.extra.access_token.params["oauth_token"]
    user.provider = oauth.provider
    user.uid = oauth.uid
    user.save
    user
  end

  def client
  end
end
