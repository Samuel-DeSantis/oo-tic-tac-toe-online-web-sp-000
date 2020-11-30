class TicTacToe

  WIN_COMBINATIONS = [
  # Horizontal Wins
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
  # Vertical Wins
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
  # Diagonal Wins
    [0, 4, 8],
    [2, 4, 6]
  ]

  def initialize(board = nil)
    @board = board || Array.new(9, " ")

  end

  def play(board)
    until over?(board) do
      turn(board)
    end
    unless winner(board) === nil
      puts "Congratulations #{winner(board)}!"
    else
      puts "Cat's Game!"
    end
  end

  def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, token = "X")
  end

  def current_player(board)
    turn_count(board) % 2 === 0 ? "X" : "O"
  end

  def position_taken?(board, index)
    !(board[index].nil? || board[index] == " ")
  end

  def valid_move?(board, index)
    (index.between?(0, 8) && !position_taken?(board, index)) ? true : false
  end

  def turn_count(board)
    turn = 0
    board.each { |item| (item === "X" || item === "O") ? turn += 1 : next}
    turn
  end

  def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
  end

  def winner
    return nil if draw?(board)

    unless won?(board) === false
      winning_combo = won?(board)
      return board[winning_combo[0]]
    end
  end

  ## Checks
  def won?(board)
    false if board_empty?(board) === true

    WIN_COMBINATIONS.each do |win_combination|
      if (board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X")
        return win_combination
      elsif (board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O")
        return win_combination
      else
        next
      end
    end
    return false # Draw : board not empty and no winning combinations
  end

  def full?
    !spaces?(board)
  end

  def draw?
    return false if !full?(board) # game in progressas

    case won?(board)
    when [0, 1, 2] # won in first row
      return false
    when [0, 4, 8] # won in L diagonal
      return false
    when [2, 4, 6] # won in R diagonal
      return false
    when false
      return true # draw
    end
  end

  def over?(board)
    return true if draw?(board)
    return true unless won?(board) === false
    return false if spaces?(board)
  end

end
