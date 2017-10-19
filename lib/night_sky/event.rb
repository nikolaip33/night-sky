class NightSky::Event

  attr_accessor :name, :date, :year, :description
  @@all = []

  def initialize(name, date, year, description)
    @name = name
    @date = date
    @year = year
    @description = description
    @@all << self
  end

  def self.new_from_item(item)
    self.new(
      item.search(".title-text").text.strip.gsub(".",""),
      item.search(".date-text").text.strip,
      2017,
      item.search("p").text.strip
    )
  end

  def self.all
    @@all
  end

end #class NightSky::Event
