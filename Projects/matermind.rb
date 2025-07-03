COLORS = %w[R G B Y O P]
CODE_LENGTH = 4
MAX_TRIES = 12

def generate_code
  CODE_LENGTH.times.map { COLORS.sample }
end

def get_player_guess
  loop do
    print "Enter your #{CODE_LENGTH}-color guess (choices: #{COLORS.join(', ')}): "
    guess = gets.chomp.upcase.chars
    return guess if valid_guess?(guess)
    puts "Invalid guess. Try again."
  end
end

def valid_guess?(guess)
  guess.size == CODE_LENGTH && guess.all? { |c| COLORS.include?(c) }
end

def evaluate_guess(secret_code, guess)
  secret = secret_code.dup
  guess = guess.dup

  black_pegs = 0
  CODE_LENGTH.times do |i|
    if guess[i] == secret[i]
      black_pegs += 1
      secret[i] = nil
      guess[i] = nil
    end
  end

  white_pegs = 0
  guess.compact.each do |color|
    if secret.include?(color)
      white_pegs += 1
      secret[secret.index(color)] = nil
    end
  end

  [black_pegs, white_pegs]
end

def play_game_as_guesser
  secret_code = generate_code
  puts "\nSecret code generated. Start guessing!"

  MAX_TRIES.times do |i|
    attempt = i + 1
    puts "\nAttempt #{attempt}:"
    guess = get_player_guess
    black, white = evaluate_guess(secret_code, guess)
    puts "Feedback: 🔲 Black Pegs: #{black}, ○ White Pegs: #{white}"

    if black == CODE_LENGTH
      puts "\n🎉 You guessed the code correctly!"
      return
    end
  end

  puts "\n❌ Out of tries! The secret code was: #{secret_code.join}"
end

# === COMPUTER AS GUESSER LOGIC ===

def all_possible_codes
  COLORS.repeated_permutation(CODE_LENGTH).to_a
end

def feedback_matches?(code, guess, expected_black, expected_white)
  black, white = evaluate_guess(code, guess)
  black == expected_black && white == expected_white
end

def play_game_as_codemaker
  puts "\nEnter a secret code for the computer to guess (e.g., R G B Y):"
  secret_code = gets.chomp.upcase.split()
  unless valid_guess?(secret_code)
    puts "Invalid code format. Using random code instead."
    secret_code = generate_code
  end

  possible_codes = all_possible_codes
  puts "\nThe computer will now try to guess your code..."

  MAX_TRIES.times do |i|
    attempt = i + 1
    guess = possible_codes.sample
    black, white = evaluate_guess(secret_code, guess)
    puts "Attempt #{attempt}: Computer guessed #{guess.join} → Feedback: 🔲 #{black}, ○ #{white}"

    possible_codes.select! { |code| feedback_matches?(code, guess, black, white) }

    if black == CODE_LENGTH
      puts "\n🤖 Computer guessed the code correctly!"
      return
    end
  end

  puts "\n❌ Computer failed to guess your code within #{MAX_TRIES} attempts."
  puts "Your secret code was: #{secret_code.join}"
end

# === MAIN MENU ===

def main_menu
  puts "Welcome to Mastermind!"
  puts "Would you like to:"
  puts "1. Guess the computer's secret code"
  puts "2. Have the computer guess your secret code"

  choice = gets.chomp
  case choice
  when "1"
    play_game_as_guesser
  when "2"
    play_game_as_codemaker
  else
    puts "Invalid choice. Try again."
    main_menu
  end
end

# Run the game
main_menu