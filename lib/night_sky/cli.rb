class NightSky::CLI

  attr_accessor :ns, :year

  def call
    self.ns = NightSky::Event #makes calling Event class methods cleaner
    start
  end

  def start
    introduction
    set_year
    main_menu
  end

  def main_menu
    puts "\n------ The Night Sky for #{self.year} ------"
    puts "(1). Lunar Calendar"
    puts "(2). Meteor Showers"
    puts "(3). Planetary Viewing"
    puts "(4). Manual Search"
  end

  def list_events_with_index(events)
    events.each.with_index(1) do |e, i|
      puts " #{i}. #{e.date} - #{e.name}" if i < 10
      puts "#{i}. #{e.date} - #{e.name}" if i >= 10
    end

    puts "Which event would you like more information for?"
    input = 0
    until input.between?(1,events.length)
      input = gets.chomp.to_i
    end
    puts events[input-1].description
  end

  def search_events
    puts "\nSearch for an Astrononical Event"
    input = gets.chomp
    results = NightSky::Event.select_by(input)
    if results.length == 0
      puts "\nSorry, 0 matches were found."
    else
      puts results.length == 1 ? "\nWe found 1 match:" : "\nWe found #{results.length} matches:"
      list_events(results)
    end
    search_events
  end

  def set_year
    puts "\nWhat year would you like to search?"
    input = 0
    input = gets.strip.to_i until input.between?(2017,2030)
    self.year = input
    NightSky::Scraper.new(input).make_events
  end

  def introduction
    puts "\nWelcome to The Night Sky"
    puts "\nThis program can provide you with dates and information on a variety of astronomical events."
    puts "To get started, we would like to know what year you are interesting in searching through."
  end

end #class NightSky::CLI
