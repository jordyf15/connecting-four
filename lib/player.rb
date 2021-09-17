class Player
  def initialize name, number
    @name = name
    @number = number
  end

  def drop_piece cage
    print "Please choose a column to drop your piece: "
    loop do
      column = gets.chomp.to_i
      if column >=1 && column <= 8 && check_column_available?(cage, column-1)
        return {piece: @number, column: column-1} 
      end
      if column < 1 || column >8
        puts "Please choose a column between 1-8!"
      else
        puts "That column is already full. Please choose another one!"
      end
    end
  end

  private
  def check_column_available? cage, column
    return true if cage[0][column] == nil
    false
  end
end