require_relative 'player'

class ComputerPlayer < Player

  def negamax(test_board, color, alpha, beta, depth = 1)
    return score(test_board) * (color == @color ? 1 : -1) if depth == 0
    best_value = -200
    best_move = nil
    test_board.pieces.each do |piece|
      piece.all_valid_moves do |move|
        test_score = -negamax(test_board[piece.pos].simulate(move),
                              toggle_color(color), -beta, -alpha, depth - 1)
        best_value = test_score if test_score > best_value
        alpha = test_score if test_score > alpha
        break if alpha >= beta
      end
    end

    best_value
  end


  def toggle_color(color)
    color == :red ? :blue : :red
  end

  def score
    value = 0

    board.pieces.each do |piece|
      multiplier = (piece.color != color ? -1 : 1)
      value += multiplier
      piece.all_valid_moves.each do
        value += 0.1 * multiplier
      end
      value += 5 * multiplier if piece.promoted
    end

    value
  end

  def turn
    best_move = best_score = best_piece= nil

    board.pieces(color).each do |piece|
      piece.all_valid_moves.each do |move|
        test_board = board[piece.pos].simulate(move)
        test_score = -1 * negamax(test_board, toggle_color(color), -200, 200)

        if best_score.nil? || test_score > best_score
          best_piece, best_move, best_score = piece, move, test_score
        end
      end
    end

    [best_piece.pos] + best_move
  end
end
