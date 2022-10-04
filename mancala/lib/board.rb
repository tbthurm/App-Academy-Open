class Board
  attr_accessor :cups, :name1, :name2

  def initialize(name1, name2)
    @name1,@name2 = name1,name2
    @cups=Array.new(14){Array.new}
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    (0...13).each do |i|
      4.times {@cups[i]<<:stone} unless i==6
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if !start_pos.between?(0,12)
    raise "Starting cup is empty" if @cups[start_pos].empty?
    true
  end

  def make_move(start_pos, curr_player)
    hand=@cups[start_pos].dup
    @cups[start_pos].clear

    (1..hand.length).each do |i|
      next_cup=(start_pos+i)%14
    if (next_cup==13 && curr_player==@name1) || (next_cup==6 && curr_player==@name2)
      start_pos+=1
      @cups[(start_pos+i)%14]<<hand.pop
    else 
      @cups[next_cup]<<hand.pop
    end
    $idx=next_cup if hand.empty? #&& next_cup!=13 || next_cup!=6
    $idx=(next_cup+1)%14 if hand.empty? && ((next_cup==13 && curr_player==@name1) || (next_cup==6 && curr_player==@name2))
    end
    render
    next_turn($idx,curr_player)
  end

  def next_turn(ending_cup_idx,curr_player)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    return :prompt if (ending_cup_idx==6 && curr_player==@name1) || (ending_cup_idx==13 && curr_player==@name2)
    return ending_cup_idx if @cups[ending_cup_idx].length>1
    return :switch if @cups[ending_cup_idx].one?
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
  end

  def one_side_empty?
    (0..5).all?{|n| @cups[n].empty?} || (7..12).all?{|n| @cups[n].empty?}               
  end

  def winner
    return :draw if @cups[6].length==@cups[13].length
    return @name1 if @cups[6].length>@cups[13].length
    return @name2 if @cups[13].length>@cups[6].length
  end
end