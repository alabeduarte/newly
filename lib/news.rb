class News
  attr_reader :url, :date, :title, :subtitle, :image
  
  def initialize(args)
    @url = args[:url]
    @keywords = args[:keywords]
    @date = args[:date]
    @title = args[:title]
    @subtitle = args[:subtitle]
    @image = args[:image]
  end
end