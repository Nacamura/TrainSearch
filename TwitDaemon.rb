load './TrainSearch/MyJSON.rb'
load './TrainSearch/MyLogger.rb'
load './TrainSearch/TwitCommunicator.rb'
load './TrainSearch/TrainSearch.rb'

class TwitDaemon
  include MyLogger

  @enabled
  @twitcom
  @trainsearch

  def call
    return if not @enabled
    @twitcom ||= TwitCommunicator.new( MyJSON.load_json("./TrainSearch/settings.txt") )
    dms = @twitcom.gather_new_direct_messages
    dms.each do |dm|
      lines = []
      dm.text.lines do |l|
        lines << l
      end
      if(lines[0].strip != "pi")
        next
      else
        parse_command(lines)
      end
    end
  end

  def parse_command(lines)
    lines.each do |l|
      case l
      when "home"
        @trainsearch ||= TrainSearch.new
        @trainsearch.route_home(@twitcom)
      end
    end
  end

  def enable
    @enabled = true
  end

  def disable
    @enabled = false
  end

end