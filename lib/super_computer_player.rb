require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer

  def move(game, mark)
    current_node = TicTacToeNode.new(game.board, mark)
    current_children = current_node.children
    node = current_children.find { |child_node| child_node.winning_node?(mark) }
    return node.prev_move_pos if node
    node = current_children.find { |child_node| !child_node.losing_node?(mark) }
    return node.prev_move_pos if node

    raise "Wait, it looks like I'm going to lose?"
  end

end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
