require 'colorize'

class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length=1
    @game_over=false
    @seq=[]
  end

  def play 
    $won=0
    while !@game_over
      take_turn
    end
      game_over_message
      reset_game
      puts "rounds won #{$won}"
      sleep(1.5)
      play
  end

  def take_turn
    system("clear")
    show_sequence
    sleep(1)
    system("clear")
    ans=require_sequence

    if compare(ans,@seq)
      $won+=1
    round_success_message 
    sleep(1)
    @sequence_length+=1
    else
      @game_over=true
    end
  end

  def compare(arr1,arr2)
    arr1.each.with_index do |el1,i|
      if el1.downcase!=arr2[i][0].downcase
        return false
      end
    end
    true
  end
      
  def show_sequence
    add_random_color
    @seq.each do |color|
      puts color.colorize(:yellow) if color=="yellow"
      puts color.colorize(:red) if color=="red"
      puts color.colorize(:green) if color=="green"
      puts color.colorize(:blue) if color=="blue"
    end

  end

  def require_sequence
    puts "Input sequence ex. rbgy"
    return gets.chomp.split("")
  end

  def add_random_color
    seq<<COLORS.sample
  end

  def round_success_message
    puts "good job"
  end

  def game_over_message
    puts "try again"
  end

  def reset_game
    @sequence_length=1
    @game_over=false
    @seq.clear
  end
end

debugger
s=Simon.new
s.play