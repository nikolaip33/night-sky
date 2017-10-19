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

  def new_from_item(item)
    
  end

end #class NightSky::Event
