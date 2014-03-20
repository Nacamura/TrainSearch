require 'twitter'

class TwitCommunicator
	include MyLogger
	def initialize(settings)
		@logger = get_logger
		Twitter.configure do |config|
			config.consumer_key = settings["consumer_key"]
			config.consumer_secret = settings["consumer_secret"]
			config.oauth_token = settings["access_token"]
			config.oauth_token_secret = settings["access_token_secret"]
		end
		@target_user = settings["target_user"]
		@count = settings["count"]
		@since_id = settings["since_id"]
	end

	def gather_new_tweets
		tweets = Twitter.user_timeline(@target_user, options={:count=>@count, :since_id=>@since_id})
		@since_id = tweets[0].id
		tweets
	end

	def update(text)
		Twitter.update(text)
	end

end