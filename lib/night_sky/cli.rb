class NightSky::CLI

  attr_accessor :ns, :year
  CHANGE = ["change", "year", "change year"]
  EXIT = ["exit", "quit", "stop"]
  MAIN = ["main", "menu", "main menu"]
  YES = ["yes","y"]
  NO = ["no", "n"]
  NONE = ["none", "no"]
  SEARCH = ["search"]
  WIDTH = 70

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
    if EXIT.include?(input.downcase)
      quit
    elsif input.to_i.between?(2010,2030)
      self.year = input
      NightSky::Scraper.new(input).make_events
    else
      set_year
    end
  end

  def change_year
    puts ""
    puts center("Change Year")
    NightSky::Event.reset!
    set_year
    main_menu
  end

  def introduction
    puts ""
    puts center("*", " ")
    puts center("*   nS  *", " ")
    puts center("*   *", " ")
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
    puts "7. Change Year - Select a new Year for Events"
    puts "   You can enter 'change year' at any time"
    puts "   You can enter 'search' at any time"
    puts "   You can enter 'quit' or 'exit' at any time"
    puts "\nPlease make a selection:"
    main_menu_nav
  end

  def main_menu_nav
    input = 0
    input = gets.chomp
    if EXIT.include?(input.downcase)
      quit
    elsif SEARCH.include?(input.downcase)
      search_events
    elsif CHANGE.include?(input.downcase)
      change_year
    elsif input.to_i.between?(1,6)
      case input.to_i
      when 1
        list_events(NightSky::Event.lunar)
      when 2
        list_events(NightSky::Event.meteor)
      when 3
        list_events(NightSky::Event.planetary)
      when 4
        list_events(NightSky::Event.seasonal)
      when 5
        list_events(NightSky::Event.eclipses)
      when 6
        search_events
      when 7
        change_year
      end
    else
      puts "Please make a valid selection."
      main_menu_nav
    end
    puts "\nWould you like to return to the Main Menu?"
    main_menu_nav_again
  end

  def main_menu_nav_again
    puts "Please enter 'yes', 'main menu', 'no', 'exit', or 'search'"
    input = gets.chomp
    if EXIT.include?(input.downcase) || NO.include?(input.downcase)
      quit
    elsif YES.include?(input.downcase) || MAIN.include?(input.downcase)
      main_menu
    elsif SEARCH.include?(input.downcase)
      search_events
    elsif CHANGE.include?(input.downcase)
      change_year
    else
      main_menu_nav_again
    end
  end

  def search_events
    puts center("Search for an Astrononical Event in #{self.year}")
    puts "\nWhat would you like to search for?"
    input = gets.chomp.downcase
    if EXIT.include?(input.downcase)
      quit
    elsif MAIN.include?(input.downcase)
      main_menu
    elsif CHANGE.include?(input.downcase)
      change_year
    else
      results = NightSky::Event.search_by(input)
      if results.length == 0
        puts "\nSorry, 0 matches were found."
      else
        puts results.length == 1 ? "\nWe found 1 match:" : "\nWe found #{results.length} matches:"
        list_events(results)
      end
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
    elsif SEARCH.include?(input.downcase)
      search_events
    elsif CHANGE.include?(input.downcase)
      change_year
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
    elsif NONE.include?(input.downcase)
    elsif SEARCH.include?(input.downcase)
      search_events
    elsif CHANGE.include?(input.downcase)
      change_year
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
    puts center("*   *", " ")
    puts center("*", " ")
    exit
  end

end #class NightSky::CLI
