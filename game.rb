require_relative "./player"

class Game
  def initialize
    @player1 = Player.new("Player 1")
    @player2 = Player.new("Player 2")
    @players = [@player1, @player2].shuffle
  end

  def status
    puts "#{@player1.name}: #{@player1.lives}/3 vs #{@player2.name}: #{@player2.lives}/3"
    puts "Current player: #{@current_player.name}"
  end

  def questions
    num1 = rand(1...20)
    num2 = rand(1...20)
    puts "#{@current_player.name}: What does #{num1} plus #{num2} equal?"
    print ">"
    @user_answer = gets.chomp.to_i
    @actual_answer = num1 + num2
  end

  def switch
    @players.rotate!
  end

  def update_life
    @current_player.lives -= 1
  end
  
  def game_over?
    @players.select{ |player| player.loser?}.length > 0
  end

  def play
    until (game_over?) do
      puts " "
      puts "------ NEW TURN -------"
      puts " "

      @current_player = @players.first
      status

      puts " "
      questions
      
      if @actual_answer == @user_answer
        puts "#{@current_player.name}: YEAY! You got it right! 🥳"
        
      else 
        puts "#{@current_player.name}: AWE! Wrong answer! 😞"
        update_life
      end

      switch
    end

    puts " "
    puts "------ GAME OVER ------"
    puts "#{@players.first.name} wins with a score of #{@players.first.lives}/3"
    puts "Good bye!"
    puts " "
  end
end