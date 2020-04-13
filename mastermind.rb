=begin
-computer will guess randomly at first but keeping the code bits that match
-if the computer guesses the right color in the wrong position, its next guess
  will include that color somewhere
=end

class Game

    $line_width = 120
    $colors = ["blue", "yellow", "red", "purple", "green", "orange"]

    def initialize
        puts "Initalizing".center($line_width)
        puts
        what_will_the_player_do
    end

    def what_will_the_player_do
        puts
        puts "Would you like to guess or make the code?".center($line_width)
        puts
        puts "Press 1 to be the guesser.....Press 2 to be the codemaker.".center($line_width)
        puts
        decision = gets.chomp
        if decision == "1"
            computer_makes_code
        elsif decision == "2"
            player_makes_code
        else 
            puts "Something went wrong.  Please enter either 1 or 2.".center($line_width)
        end
    end

    def computer_makes_code
        @computer_made = true
        @secret_code = [" ", " ", " ", " "]
        @secret_code.map! do |color|
            color = $colors[(rand(6)-1)]
        end
        count_secret_code
        enter_the_game
    end

    def player_makes_code
        @computer_made = false
        @secret_code = [" ", " ", " ", " "]
        i = 1
        @secret_code.map! do |color|
            puts "What would you like slot #{i} to be?".center($line_width)
            i += 1
            color = gets.chomp
                #if input == "blue" || input == "yellow" || input == "red" || input == "purple" || input == "green" || input == "orange"
                #    color = input
        end
        count_secret_code
        enter_the_game
    end

    def count_secret_code
        @blue_count = @secret_code.count("blue")
        @yellow_count = @secret_code.count("yellow")
        @red_count = @secret_code.count("red")
        @purple_count = @secret_code.count("purple")
        @green_count = @secret_code.count("green")
        @orange_count = @secret_code.count("orange")
    end

    def enter_the_game #needs to have game over checker built in.. loop until game over
        @guess_count = 1
        if @computer_made
            until @game_over do
                self.get_player_guess
                self.check_guess
                game_over
                @guess_count += 1
            end
        elsif @computer_made == false
            until @game_over do
                self.get_computer_guess
                self.check_guess
                game_over
                @guess_count += 1
            end
        end
    end

    def get_computer_guess #this is still unsofisticated (random guessing)... should adjust strategy based on success of last guess
        @current_guess = ["____", "____", "____", "____"]
        @current_guess.map! do |color|
            color = $colors[(rand(6)-1)]
        end
        puts "----------------------------------------------------------------------------------------------".center($line_width)
        puts "|                                          Guess #{@guess_count}                                           |".center($line_width)
        puts "----------------------------------------------------------------------------------------------".center($line_width)
        puts
        puts
        puts "--------------Secret-Code--------------".center($line_width)
        puts "|      #{@secret_code.join(" | ")}      |".center($line_width)
        puts "----------------------------------------".center($line_width)
        puts
        puts "-------------Computer-Guess-------------".center($line_width)
        puts "|      #{@current_guess.join(" | ")}      |".center($line_width)
        puts "----------------------------------------".center($line_width)
        puts
        #if @exactly_correct > 0

        #-computer will guess randomly at first but keeping the code bits that match
        #-if the computer guesses the right color in the wrong position, its next guess
        #will include that color somewhere
    end

    def game_over
        @game_over = false
        if @guess_count == 12 || @exactly_correct == 4
            @game_over = true
            puts "GAME OVER".center($line_width)
            puts
                if @exactly_correct == 4 && @computer_made == true
                    puts "You guessed the secret code in #{@guess_count} guesses!".center($line_width)
                elsif @exactly_correct == 4 && @computer_made == false
                    puts "The computer guessed your code in #{@guess_count} guesses!".center($line_width)
                else
                    puts "The secret code was not guessed!".center($line_width)
                end
                puts
        end
    end

    def get_player_guess
        @current_guess = ["____", "____", "____", "____"] #resets current guess for display purposes
        puts
        puts "----------------------------------------------------------------------------------------------".center($line_width)
        puts "|                                          Guess #{@guess_count}                                           |".center($line_width)
        puts "----------------------------------------------------------------------------------------------".center($line_width)
        puts "Please enter your guesses.".center($line_width)
        puts
        puts "Possible Colors: blue, red, green, yellow, orange, purple".center($line_width)
        puts 
        puts "Remember, duplicate colors are allowed.".center($line_width)
        puts
        puts "Enter your guesses, separated by one space".center($line_width)
        raw_guess = gets.chomp
        raw_array = raw_guess.split(" ")
        i = 1 
        while i < 5 do
            @current_guess[i-1] = raw_array[i-1]
            i += 1
        end
        puts "----------------------------------------".center($line_width)
        puts "|      #{@current_guess.join(" | ")}      |".center($line_width)
        puts "----------------------------------------".center($line_width)
    end

    def check_guess
        blue = @current_guess.count("blue") #current guess count of appearance of colors... need to compare these with the actual code 
        yellow = @current_guess.count("yellow")
        red = @current_guess.count("red")
        purple = @current_guess.count("purple")
        green = @current_guess.count("green")
        orange = @current_guess.count("orange")
        guess_colors = {"blue" => @current_guess.count("blue"),
                        "yellow" => @current_guess.count("yellow"),
                        "red" => @current_guess.count("red"),
                        "purple" => @current_guess.count("purple"),
                        "green" => @current_guess.count("green"),
                        "orange" => @current_guess.count("orange")
                        }
        @secret_colors = {"blue" => @blue_count,
                          "yellow" => @yellow_count,
                          "red" => @red_count,
                          "purple" => @purple_count,
                          "green" => @green_count,
                          "orange" => @orange_count
                          }
        secret_colors = @secret_colors
        i = 0
        @exactly_correct = 0
        @inexactly_correct = 0
        while i < 4 do #checks for exact matches
            if @secret_code[i] == @current_guess[i]
                @exactly_correct += 1
                case @secret_code[i]
                when "blue"
                    secret_colors["blue"] -= 1
                    guess_colors["blue"] -= 1
                when "yellow"
                    secret_colors["yellow"] -= 1
                    guess_colors["yellow"] -= 1
                when "red"
                    secret_colors["red"] -= 1
                    guess_colors["red"] -= 1
                when "purple"
                    secret_colors["purple"] -= 1
                    guess_colors["purple"] -= 1
                when "green"
                    secret_colors["green"] -= 1
                    guess_colors["green"] -= 1
                when "orange"
                    secret_colors["orange"] -= 1
                    guess_colors["orange"] -= 1
                end
            end
            i += 1
        end
        y = 0
        while y < 6 do
            if (guess_colors[$colors[y]] > 0) && (secret_colors[$colors[y]] > 0) #if both the guess and the real code have this color
                #until loop take these varibale to 0
                until guess_colors[$colors[y]] == 0 || secret_colors[$colors[y]] == 0
                    @inexactly_correct += 1
                    guess_colors[$colors[y]] -= 1
                    secret_colors[$colors[y]] -= 1
                end
            end
            y += 1
        end
        puts "----------------------------------------------------------------------------------------------".center($line_width)
        puts "|                   #{@exactly_correct} of guesses are correct in both color and position.                     |".center($line_width)
        puts "|                                                                                            |".center($line_width)
        puts "|                   #{@inexactly_correct} of guesses are correct in color but not position.                      |".center($line_width)
        puts "----------------------------------------------------------------------------------------------".center($line_width)
        puts
    end
    
end

game1 = Game.new