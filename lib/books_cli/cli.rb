require 'colorize'
require "tty-prompt"
require "httparty"

class BooksCli::CLI
    
    def welcome
        puts "Welcome to Read It!".red.bold
        sleep(1)
        puts "A magical library where your wildest dreams can come true, just by turning the page on your next quest. Dive into the unknown, your journey awaits...".yellow
        sleep(2)
        menu
    end 

    def menu
        selection = prompt.select("Would you like to search for a new adventure or revist one from the past?",[
            {name: 'Search New Book', value: 1},
            {name: 'View My Library', value: 2}
        ])

        if selection == 1
            search_book_title
        else selection == 2
            view_library
        end
    end 

    def search_book_title
        puts "Your chariot awaits."
        sleep(1)
        puts "Please enter the realm in which you would like to explore...".blue.bold
        # Search topic and return a list of 5 books matching that query.
        search_topic = gets.chomp
        response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=#{search_topic}&maxResults=5")
        items = response.parsed_response['items']
        # Return book's author, title, and publishing company.
        items.each do |item|
        puts "#{item["volumeInfo"]["title"]} written by #{item["volumeInfo"]["authors"][0]} published by #{item["volumeInfo"]["publisher"]}"
        end

        

        
    end

    def view_library
        

        # View a “Reading List” with all the books the user has selected from their queries -- this is a local reading list and not tied to Google Books’s account features.
    end

    private
    
    def prompt
        prompt = TTY::Prompt.new

    end
end 




# A user should be able to select a book from the five displayed to save to a “Reading List”