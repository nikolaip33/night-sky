class NightSky::CLI

  EXIT = ["exit", "quit", "stop"]
  MAIN = ["main", "menu"]
  YES = ["yes","y"]
  NO = ["no", "n"]
  attr_accessor :ns, :year

  def call
    start
  end

  def start
    introduction
    set_year
    main_menu
  end

  def set_year
    puts "Please enter a year from between 2010 and 2030"
    input = nil
    input = gets.chomp
    if EXIT.include?(input)
      quit
    elsif input.to_i.between?(2010,2030)
      self.year = input
      NightSky::Scraper.new(input).make_events
    else
      set_year
    end
  end

  def introduction
    puts "\n---------------- Welcome to The Night Sky ------------------"
    puts "\nThis program can provide you with dates and information on a variety of astronomical events."
    puts "To get started, we would like to know what year you are interested in searching through."
    puts "\We have records that range from the year 2010 all the way through 2030."
    puts ""
  end

  def main_menu
    puts "\n----------------- The Night Sky for #{self.year} -------------------"
    puts "\n1. Lunar Calendar - Moon Phase Dates & Times"
    puts "2. Meteor Showers - Information, Dates & Times"
    puts "3. Planetary Viewing - Best Gazing Dates & Times"
    puts "4. Seasonal - Equinox and Solstice Dates & Times"
    puts "5. Eclpises - Information, Dates & Times"
    puts "6. Search - Search By Keyword or Month"
    puts "   You can enter 'quit' or 'exit' at any time"
    puts "\nPlease make a selection:"
  end

  def main_menu_nav
    input = 0
    input = gets.chomp


  end

  # Screens for each option off the menu - seems easiest to maintain but is the
  # least dynamic.

  def search_events_container

  end

  def search_events
    puts "\n--------- Search for an Astrononical Event in #{self.year} ---------"
    input = gets.chomp.downcase
    exit if EXIT.include?(input.downcase)
    results = NightSky::Event.search_by(input)
    if results.length == 0
      puts "\nSorry, 0 matches were found."
    else
      puts results.length == 1 ? "\nWe found 1 match:" : "\nWe found #{results.length} matches:"
      list_events(results)
    end
  end

  def display_option(title, term)
    puts "\n------------- #{title} for the Year #{self.year} -------------"
    puts ""
    list_events(NightSky::Event.select_by("term"))
  end

  # methods for populating and formatting screens

  def list_events(events)
    events.each.with_index(1) do |e, i|
      puts " #{i}. #{e.date} - #{e.name}" if i < 10
      puts "#{i}. #{e.date} - #{e.name}" if i >= 10
    end

    puts "Which event would you like more information for?"
    input = 0
    input = gets.chomp.to_i until input.between?(1,events.length)
    more_details(events[input-1])
  end

  def more_details(event)
    parts = event.details.split(".")
    title = parts.shift
    details = parts.join(".").strip << "."

    puts "\n#{title} -------------------"
    puts details
  end

  def quit
    puts "\n--------------------- Thank you! ---------------------------"
    puts "           Get out and enjoy The Night Sky"
    exit
  end

end #class NightSky::CLI
