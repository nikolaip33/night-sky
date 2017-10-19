class NightSky::CLI

  EXIT = ["exit", "main", "main menu"]
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
    puts "\n----------------- The Night Sky for #{self.year} -------------------"
    puts "\n(1). Lunar Calendar - Moon Phase Dates & Times"
    puts "(2). Meteor Showers - Information, Dates & Times"
    puts "(3). Planetary Viewing - Best Gazing Dates & Times"
    puts "(4). Seasonal - Equinox and Solstice Dates & Times"
    puts "(5). Ecplises - Information, Dates & Times"
    puts "(6). Manual Search - Search By Term"
  end

  def list_events_with_index(events)
    events.each.with_index(1) do |e, i|
      puts " #{i}. #{e.date} - #{e.name}" if i < 10
      puts "#{i}. #{e.date} - #{e.name}" if i >= 10
    end

    puts "Which event would you like more information for?"
    input = 0
    input = gets.chomp.to_i until input.between?(1,events.length)
    puts events[input-1].description
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
    puts "To get started, we would like to know what year you are interested in searching through."
  end

  def search_events
    puts "\n--------- Search for an Astrononical Event in #{self.year} ---------\n"
    input = gets.chomp.downcase
    main_menu if EXIT.include?(input.downcase)
    results = ns.search_by(input)
    if results.length == 0
      puts "\nSorry, 0 matches were found."
    else
      puts results.length == 1 ? "\nWe found 1 match:" : "\nWe found #{results.length} matches:"
      list_events_with_index(results)
    end
    search_events
  end


  def quit
    puts "\nI hope you enjoy The Night Sky"
  end

end #class NightSky::CLI
