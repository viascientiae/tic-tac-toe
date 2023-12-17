class Player

  attr_reader :name, :token

  def initialize(name, token)
    @name = name
    @token = token
  end

end

class Board

  attr_reader :board

  def initialize
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def display
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "---+---+---"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "---+---+---"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

end

class Game

  attr_reader :player1, :player2, :board

  WINNING_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ]

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new
    @current_player = @player1
  end

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

  def prompt_move
    puts "#{@current_player.name}, please place your token #{@current_player.token} on an empty cell in the board."
    gets.chomp.to_i
  end

  def update_board(position)
    if (1..9).include?(position) && (1..9).include?(@board.board[position-1])
      @board.board[position-1] = @current_player.token
      true
    else
      puts "Invalid move. Please try again."
      false
    end
  end

  def game_over?
    win? || draw?
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def win?
    WINNING_COMBINATIONS.any? do |combination|
      combination.map { |index| @board.board[index] }.uniq == [@current_player.token]
    end
  end

  def draw?
    !@board.board.any? { |cell| cell.is_a?(Integer) } && !win?
  end

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

  puts "Enter name of Player 1"
  player1_name= gets.chomp
  player1 = Player.new(player1_name, "X")
  puts "Welcome #{player1.name}, you'll be playing #{player1.token} token"

  puts "Enter name of Player 2"
  player2_name = gets.chomp
  player2 = Player.new(player2_name, "O")
  puts "Welcome #{player2.name}, you'll be playing #{player2.token} token"

  new_game = Game.new(player1, player2)
  new_game.play
