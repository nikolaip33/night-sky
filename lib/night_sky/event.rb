class NightSky::Event

  attr_accessor :name, :date, :year, :description
  @@all = []

  def initialize(name, date, year, description)
    @name = name
    @date = abreviate_date(date)
    @year = year
    @description = description
    @@all << self
  end

  def abreviate_date(date)
    parts = date.split(" ")
    parts[0] = parts[0][0..2]
    parts.join(" ")
  end

  def self.new_from_item(item)
    self.new(
      item.search(".title-text").text.strip.gsub(".",""),
      item.search(".date-text").text.strip,
      2017,
      item.search("p").text.strip
    )
  end

  def self.lunar_calendar
    @@all.select { |event| event.name.include?("Moon") }
  end

  def self.all
    @@all
  end

end #class NightSky::Event
