class Menu

  @@menu_header = %{
===========================================
   TIC TAC TOE : By Sava & Kevin
===========================================

Welcome to Tic Tac Toe. Play if you dare 😈
  }

  def self.show_welcome
   content = %{
     1. Start game
     2. Quit
   }

    puts "#{@@menu_header}#{content}"
    print 'Choose your destiny... '
  end

  def self.show_game(game)
    message = "\n\n#{game.players[:X].name} vs #{game.players[:O].name}"
    instructions = %{
===========================================

Instructions:
1. Each player gets a turn at the game
  - The prompt will show who's turn it is (e.g. Kevin's Turn: )
2. Enter the position you wish to mark (e.g A2)
3. Press '2' to quit the game any time.
}

    puts "#{message}#{instructions}"
  end

end
