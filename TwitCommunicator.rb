require 'twitter'

class TwitCommunicator
	include MyLogger
	attr_accessor :since_id
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
		Twitter.user_timeline(@target_user, options={:count=>@count, :since_id=>@since_id})
	end

	def route_home
		text = "acception "
		routes = []
		j = JorudanSearch.new
		text = text + ((j.routes("六本木一丁目", "ひばりヶ丘（東京）", "", 300)[0]).time) + " "
		text = text + ((j.routes("六本木一丁目", "ひばりヶ丘（東京）", "小竹向原", 300)[0]).time) + " "
		text = text + ((j.routes("神谷町", "ひばりヶ丘（東京）", "", 300)[0]).time) + " "
		Twitter.update(text)
	end

end