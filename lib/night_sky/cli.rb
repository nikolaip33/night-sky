class NightSky::CLI

  attr_accessor :ns, :year
  EXIT = ["exit", "quit", "stop"]
  MAIN = ["main", "menu"]
  YES = ["yes","y"]
  NO = ["no", "n"]
  WIDTH = 70

  def call
    start
  end

  def start
    introduction
    set_year
    main_menu
    search_events
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
    puts center("Welcome to The Night Sky")
    puts wrap("\nThis program can provide you with dates and information on a variety of astronomical events. To get started, we would like to know what year you are interested in searching through.")
    puts "\nOur records range from the year 2010 all the way through 2030."
    puts ""
  end

  def main_menu
    puts center("The Night Sky for #{self.year}")
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


  def search_events
    puts center("Search for an Astrononical Event in #{self.year}")
    puts "\n"
    puts "What would you like to search for?"
    input = gets.chomp.downcase
    exit if EXIT.include?(input.downcase)
    results = NightSky::Event.search_by(input)
    if results.length == 0
      puts "\nSorry, 0 matches were found."
    else
      puts results.length == 1 ? "\nWe found 1 match:" : "\nWe found #{results.length} matches:"
      list_events(results)
    end
    puts "\nWould you like to search again?"
    search_again
  end

  def search_again
    puts "Please enter 'yes', 'no' or 'exit'"
    input = gets.chomp
    if EXIT.include?(input.downcase)
      quit
    elsif YES.include?(input.downcase)
      search_events
    elsif NO.include?(input.downcase)
      main_menu
    else
      search_again
    end
  end

  # methods for populating and formatting screens

  def list_events(events)
    events.each.with_index(1) do |e, i|
      puts " #{i}. #{e.date} - #{e.name}" if i < 10
      puts "#{i}. #{e.date} - #{e.name}" if i >= 10
    end

    puts "Which event would you like more information for?"
    select_event(events)
  end

  def select_event(events)
    input = 0
    input = gets.chomp
    if EXIT.include?(input.downcase)
      quit
    elsif input.to_i.between?(1,events.length)
      more_details(events[input.to_i-1])
    else
      puts "Please choose and event from the list."
      select_event(events)
    end
  end

  def more_details(event)
    #formatter
    parts = event.details.split(".")
    title = parts.shift + " "
    until title.length == WIDTH
      title << "-"
    end
    details = parts.join(".").strip << "."

    #writer
    puts "\n#{title}"
    puts wrap(details)
  end

  def center(string, c = "-")
    title = " #{string} "
    until title.length >= WIDTH
      title.prepend(c)
      title << (c)
    end
    title.prepend("\n")
  end

  def wrap(s)
	  s.gsub(/(.{1,#{WIDTH}})(\s+|\Z)/, "\\1\n")
	end

  def quit
    puts center("Thank you!", "-")
    puts center("Get out and enjoy The Night Sky", " ")
    exit
  end

end #class NightSky::CLI
