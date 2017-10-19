class NightSky::Event

  attr_accessor :name, :date, :date_full, :year, :details
  # @@all = Hash.new([])
  @@all = []

  def initialize(name, date, year, details)
    @name = name
    @date_full = date
    @date = abreviate_date(date)
    @year = year
    @details = details
    @@all << self
  end

  def abreviate_date(date)
    parts = date.split(" ")
    parts[0] = parts[0][0..2]
    parts.join(" ")
  end

  def self.new_from_item(item, year)
    self.new(
      item.search(".title-text").text.strip.gsub(".",""),
      item.search(".date-text").text.strip,
      year,
      item.search("p").text.strip
    )
  end

  def self.select_by(term)
    all.select { |e| e.name.downcase.include?(term.downcase) }
  end

  def self.search_by(term)
    all.select { |e| e.details.downcase.include?(term.downcase) }
  end

  def self.lunar_calendar
    select_by("Moon")
  end

  def self.meteor_showers
    select_by("Meteor")
  end

  def self.all
    @@all
  end

  def self.reset!
    @@all.clear
  end

end #class NightSky::Event
