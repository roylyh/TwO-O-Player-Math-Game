require "./Player.rb"
require "./Question.rb"

class Game
  def initialize
    @player1 = Player.new("Player 1")
    @player2 = Player.new("Player 2")
    @round = 1
  end

  def getQuestion
    @question = Question.new
    puts "----- NEW TURN -----" unless @round == 1
    if @player1.turn
      print "#{@player1.name}:"
    else
      print "#{@player2.name}:"
    end
    puts " #{@question.question}"
  end

  def check_answer?
    gets.chomp.to_i == @question.answer
  end

  def game_loop
    getQuestion
    if check_answer?
      puts "YES! You are correct."
      if @player1.turn
        # raise @player1.inspect
        @player1.turn = false
        @player2.turn = true
      else
        @player1.turn = true
        @player2.turn = false
      end
    else
      puts "No! You are incorrect."
      if @player1.turn
        @player1.turn = false
        @player2.turn = true
        @player1.lives -= 1
      else
        @player1.turn = true
        @player2.turn = false
        @player2.lives -= 1
      end
    end
    print_result
    check_winner
    @round += 1
  end

  def print_result
    puts "#{@player1.name}: #{@player1.lives}/3 vs #{@player2.name}: #{@player2.lives}/3"
  end

  def print_final_result(winner)
      puts "----- GAME OVER -----"
      puts "#{winner.name} wins with a score of #{winner.lives}/3 "
      puts "Thank you, play again"
  end

  def check_winner
    if @player1.lives == 0
      print_final_result(@player2)
    elsif @player2.lives == 0
      print_final_result(@player1)
    else
      game_loop
    end
  end
end
