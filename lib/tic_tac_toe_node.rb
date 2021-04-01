require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      return true if @board.won? && @board.winner != evaluator
      return false
    else
      # when it's the player's turn
      if self.next_mover_mark == evaluator
        losses_count = 0
        self.children.each do |child_node| 
          return false if child_node.board.tied?
          losses_count += 1 if child_node.losing_node?(evaluator)
        end
        return true if losses_count == self.children.length
      # when it's the opponent's turn
      else
        self.children.each do |child_node|
          return true if child_node.losing_node?(evaluator)
        end
      end
    end
    false
  end

  def winning_node?(evaluator)
    if @board.over?
      return true if @board.winner == evaluator
      return false
    else
      # when it's the player's turn
      if self.next_mover_mark == evaluator
        self.children.each do |child_node|
          return true if child_node.winning_node?(evaluator)
        end
      #when it's the opponent's turn
      else
        wins_count = 0
        self.children.each do |child_node|
          wins_count += 1 if child_node.winning_node?(evaluator)
        end
        return true if wins_count == self.children.length
      end
    end
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    child_boards = []
    child_mark = ((@next_mover_mark == :x) ? :o : :x)
    (0...3).each do |row|
      (0...3).each do |col|
        pos = [row, col]
        if @board.empty?(pos)
          next_possible_board = @board.dup
          next_possible_board[pos] = @next_mover_mark
          child_boards << TicTacToeNode.new(next_possible_board, child_mark, pos)
        end
      end
    end
    child_boards
  end

end
