class Player
  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class Board
  def initialize
    @grid = Array.new(3) { Array.new(3, " ") }
  end
  
  def display 
    puts "-------------"
    @grid.each do |row|
      puts "| #{row.join(" | ")} |"
      puts "-------------"
    end
  end
    
  def place(marker, row, col)
    if valid_move?(row, col)
      @grid[row][col] = marker
      true
    else
      false
    end
  end

  def full?
    @grid.flatten.none?(" ")
  end

  def winner?(marker)
    size = 3

    size.times do |i|
      return true if @grid[i].all? {|cell| cell ==marker} # row
      return true if (0...size).all? {|j| @grid[j][i] == marker} # col
    end

    diag1 = (0...size).all? { |i| @grid[i][i] == marker}
    diag2 = (0...size).all? { |i| @grid[i][size - 1 - i] == marker }

    diag1 || diag2
  end

  private

  def valid_move?(row, col)
    row.between?(0,2) && col.between?(0,2) && @grid[row][col] == " "
  end  
end

class Game
  def initialize
    puts "Welcome to Tic Tac Toe!"
    @board = Board.new
    @current_player = nil
    setup_players
  end

  def play
    until game_over?
      take_turn
      switch_players
    end

    @board.display
    if winner?
      puts "🎉 Congratulations #{@current_player.name}! You won!"
    else
      puts "It's a draw!"
    end
  end

  private

  def setup_players
    puts "Player 1, what is your name?"
    name1 = gets.chomp
    player1 = Player.new(name1, "X")

    puts "Player 2, what is your name?"
    name2 = gets.chomp
    player2 = Player.new(name2, "O")

    @players = [player1, player2]
    @current_player = player1
  end

  def take_turn
    @board.display
    puts "#{@current_player.name} (#{@current_player.marker}), it's your turn."
    row, col = get_move
    @board.place(@current_player.marker, row, col)
  end

  def get_move
    loop do
      puts "Enter move (row and column: 0 2):"
      input = gets.chomp.split.map(&:to_i)

      if input.size == 2 && input.all? { |n| n.between?(0, 2) }
        row, col = input

        if @board.place(@current_player.marker, row, col)
          break [row, col]
        else
          puts "That space is already taken. Try again."
        end
      else
        puts "Invalid input. Please enter two numbers from 0 to 2."
      end
    end
  end

  def switch_players
    @current_player = (@current_player == @players[0]) ? @players[1] : @players[0]
  end

  def game_over?
    winner? || @board.full?
  end

  def winner?
    @board.winner?(@current_player.marker)
  end
end   

  # Start the game
game = Game.new
game.play