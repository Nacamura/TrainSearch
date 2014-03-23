require 'clockwork'
load './TwitDaemon.rb'

@twitdaemon

module Clockwork
  handler do |job|
  	if(job=='TwitDaemon')
  		@twitdaemon ||= TwitDaemon.new
  		@twitdaemon.execute
  	end
  end

  every(20.seconds, 'TwitDaemon')
end