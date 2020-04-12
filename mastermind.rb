=begin
-eventually, allow the human to make the code
-computer will guess randomly at first but keeping the code bits that match
-if the computer guesses the right color in the wrong position, its next guess
  will include that color somewhere
  -code is made up of 4 different colors (selected from 6 different possible colored pegs)
=end

#red, blue, yellow, purple, green, orange

#twelve guesses max

#system to calculate if the colors are correct or in the right spot
# and print out the results

class Game

    $line_width = 120
    $colors = ["blue", "yellow", "red", "purple", "green", "orange"]

    def initialize
        puts "Initalizing".center($line_width)
        puts
        makes_secret_code
        enter_the_game
    end

    def makes_secret_code
        @secret_code = [" ", " ", " ", " "]
        @secret_code.map! do |color|
            color = $colors[(rand(6)-1)]
        end
        count_secret_code
        print @secret_code #TAKE THIS OUT BEFORE FINAL VERSION
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
        until game_over do
            self.get_guess
            self.check_guess
            game_over
            @guess_count += 1
        end
    end

    def game_over
        @game_over = false
        if @guess_count == 13 || @exactly_correct == 4
            @game_over = true
        end #needs to account for correct guess on guess 12
    end

    def get_guess
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
        inexactly_correct = 0
        while i < 4 do #checks for exact matches
            if @secret_code[i] == @current_guess[i]
                @exactly_correct += 1
                case @secret_code[i]
                when "blue"
                    secret_colors["blue"] -= 1
                    blue -= 1
                when "yellow"
                    secret_colors["yellow"] -= 1
                    yellow -= 1
                when "red"
                    secret_colors["red"] -= 1
                    red -= 1
                when "purple"
                    secret_colors["purple"] -= 1
                    purple -= 1
                when "green"
                    secret_colors["green"] -= 1
                    green -= 1
                when "orange"
                    secret_colors["orange"] -= 1
                    orange -= 1
                end
            end
            i += 1
        end
        y = 0
        while y < 6 do
            if (guess_colors[$colors[y]] > 0) && (secret_colors[$colors[y]] > 0) #if both the guess and the real code have this color
                #until loop take these varibale to 0
                until guess_colors[$colors[y]] == 0 || secret_colors[$colors[y]] == 0
                    inexactly_correct += 1
                    guess_colors[$colors[y]] -= 1
                    secret_colors[$colors[y]] -= 1
                end
            end
            y += 1
        end
        puts "----------------------------------------------------------------------------------------------".center($line_width)
        puts "|                 #{@exactly_correct} of your guesses are correct in both color and position.                  |".center($line_width)
        puts "|                                                                                            |".center($line_width)
        puts "|                 #{inexactly_correct} of your guesses are correct in color but not position.                   |".center($line_width)
        puts "----------------------------------------------------------------------------------------------".center($line_width)
        puts
    end
    
end

game1 = Game.new