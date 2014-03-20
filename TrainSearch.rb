load './JorudanSearch.rb'

class TrainSearch
  include MyLogger

  @jorudan

  def route_home(twitcom)
    text = "acception\n"
    @jorudan ||= JorudanSearch.new
    text += @jorudan.route_home
    twitcom.update(text)
    text
  end

end