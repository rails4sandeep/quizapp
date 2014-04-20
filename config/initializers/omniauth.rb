OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_CONSUMER_KEY'], ENV['FACEBOOK_CONSUMER_SECRET'],
  :options => ['user_status','publish_actions','status_updates']
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end