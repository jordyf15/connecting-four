require_relative "string"

class Cage
  attr_reader :columns
  def initialize 
    @columns = [
      [nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil],
    ]
  end

  def insert_piece player_number, chosen_column
    row = 0
    while row <7 && @columns[row+1][chosen_column] == nil
      row+=1
    end
    @columns[row][chosen_column] = player_number
  end

  def check_game_over 
    return 'win' if check_cage_horizontal? || check_cage_vertical? || check_cage_cross?
    return 'draw' if check_cage_full?
    'continue'
  end

  def print_cage
    puts "==================="
    @columns.each do |row|
      print "| "
      row.each do |grid|
        print "\u26aB" if grid == nil
        print "\u26aB".red if grid == 1
        print "\u26aB".blue if grid == 2
      end
      print "|"
      puts "\n"
    end
    puts "==================="
    puts "  1 2 3 4 5 6 7 8"
  end

  private
  def check_cage_full?
    @columns[0].all? {|grid| grid !=nil}
  end

  def check_cage_horizontal?
    @columns.each do |row|
      consecutive = 0
      current = ''
      row.each do |grid|
        if grid != current
          current = grid
          consecutive = 1
        elsif grid != nil
          consecutive += 1
        end
        break if consecutive == 4
      end
      return true if consecutive == 4
    end
    return false
  end

  def check_cage_vertical?
    8.times do |column|
      consecutive = 0
      current = ''
      @columns.each do |row|
        grid = row[column]
        if grid != current
          current = grid
          consecutive = 1
        elsif grid != nil
          consecutive+=1
        end
        break if consecutive == 4
      end
      return true if consecutive == 4
    end
    return false
  end

  def check_cage_cross?
    @columns.each.with_index do |row, row_idx|
      row.each.with_index do |grid, col_idx|
        return true if cross?(grid, row_idx, col_idx, 'lower_right')
        return true if cross?(grid, row_idx, col_idx, 'lower_left')
        return true if cross?(grid, row_idx, col_idx, 'upper_right')
        return true if cross?(grid, row_idx, col_idx, 'upper_left')
      end
    end
    return false
  end

  def cross? grid, row_idx, col_idx, direction
    cross_col_idx = col_idx
    cross_row_idx = row_idx
    consecutive = 0
    while cross_col_idx >= 0 && cross_col_idx <= 7 && cross_row_idx >= 0 && cross_row_idx <= 7
      current = @columns[cross_row_idx][cross_col_idx]
      if current == grid && current != nil
        consecutive+=1
      else
        break
      end
      break if consecutive == 4
      if direction == "lower_left"
        cross_row_idx+=1
        cross_col_idx+=1
      elsif direction == "lower_right"
        cross_row_idx+=1
        cross_col_idx-=1
      elsif direction == "upper_left"
        cross_row_idx-=1
        cross_col_idx-=1
      else
        cross_row_idx-=1
        cross_col_idx+=1
      end
    end
    return consecutive == 4
  end
end