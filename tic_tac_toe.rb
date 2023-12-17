# Define a class named Player
class Player
  # attr_reader creates getter methods for name and token attributes.
  attr_reader :name, :token

  # Initialize method for creating a new Player instance.
  def initialize(name, token)
    @name = name  # Store the player's name.
    @token = token  # Store the player's token (e.g., 'X' or 'O').
  end
end

# Define a class named Board
class Board
  # attr_reader creates a getter method for the board attribute.
  attr_reader :board

  # Initialize method for creating a new Board instance.
  def initialize
    # Set up the board as an array of numbers 1 to 9.
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  # Method to display the board in a 3x3 grid format.
  def display
    # Display the board with dividers.
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "---+---+---"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "---+---+---"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
end

# Define a class named Game
class Game
  # attr_reader allows read-only access to player1, player2, and board.
  attr_reader :player1, :player2, :board

  # Constant array of winning combinations for the game.
  WINNING_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ]

  # Initialize method for setting up a new game with two players.
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new
    @current_player = @player1
  end

  # Main game loop.
  def play
    loop do
      @board.display
      position = prompt_move
      next unless update_board(position)
      break if game_over?
      switch_player
    end
    display_result
  end

  # Prompt the current player for a move.
  def prompt_move
    # Request input from the current player.
    puts "#{@current_player.name}, please place your token #{@current_player.token} on an empty cell in the board."
    gets.chomp.to_i  # Convert input to an integer.
  end

  # Update the board with the current player's token.
  def update_board(position)
    # Check if the move is valid.
    if (1..9).include?(position) && (1..9).include?(@board.board[position-1])
      @board.board[position-1] = @current_player.token
      true
    else
      puts "Invalid move. Please try again."
      false
    end
  end

  # Check if the game is over (win or draw).
  def game_over?
    win? || draw?
  end

  # Switch the current player.
  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  # Check if the current player has won.
  def win?
    WINNING_COMBINATIONS.any? { |combination| combination.map { |index| @board.board[index] }.uniq == [@current_player.token] }
  end

  # Check if the game is a draw.
  def draw?
    !@board.board.any? { |cell| cell.is_a?(Integer) } && !win?
  end

  # Display the result of the game.
  def display_result
    if win?
      @board.display
      puts "Congratulations #{@current_player.name}, you've won the game!"
    elsif draw?
      @board.display
      puts "The game is draw."
    end
  end
end

# Game initialization and starting logic
puts "Enter name of Player 1"
player1_name = gets.chomp
player1 = Player.new(player1_name, "X")
puts "Welcome #{player1.name}, you'll be playing #{player1.token} token"

puts "Enter name of Player 2"
player2_name = gets.chomp
player2 = Player.new(player2_name, "O")
puts "Welcome #{player2.name}, you'll be playing #{player2.token} token"

new_game = Game.new(player1, player2)
new_game.play
