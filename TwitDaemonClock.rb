require 'clockwork'
load './TwitDaemon.rb'

@twitdaemon

module Clockwork
  handler do |job|
  	job.call
  end

  every(20.seconds, (@twitdaemon ||= TwitDaemon.new))
  every(1.day, lambda {@twitdaemon.enable}, :at=>'16:00')
  every(1.day, lambda {@twitdaemon.disable}, :at=>'19:00')
end