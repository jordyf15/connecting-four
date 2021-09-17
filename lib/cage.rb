require_relative "string"

class Cage
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
    return 'win' if check_cage_horizontal? || check_cage_vertical? || check_cage_left_cross? || check_cage_right_cross?
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

  def check_cage_left_cross?
    @columns.each.with_index do |row, row_idx|
      row.each.with_index do |grid, col_idx|
        return true if left_lower_cross?(grid, row_idx, col_idx)
        return true if left_upper_cross?(grid, row_idx, col_idx)
      end
    end
    return false
  end

  def check_cage_right_cross?
    @columns.each.with_index do |row, row_idx|
      row.each.with_index do |grid, col_idx|
        return true if right_upper_cross?(grid, row_idx, col_idx)
        return true if right_lower_cross?(grid, row_idx, col_idx)
      end
    end
    return false
  end

  def right_upper_cross? grid, row_idx, col_idx
    up_col_idx = col_idx
    up_row_idx = row_idx
    consecutive = 0
    while up_col_idx >= 0 && up_col_idx <= 7 && up_row_idx >= 0 && up_row_idx <= 7
      current = @columns[up_row_idx][up_col_idx]
      if current == grid && current != nil
        consecutive+=1
      else
        break
      end
      break if consecutive == 4
      up_row_idx-=1
      up_col_idx+=1
    end
    return consecutive == 4
  end

  def right_lower_cross? grid, row_idx, col_idx
    down_col_idx = col_idx
    down_row_idx = row_idx
    consecutive = 0
    while down_col_idx >= 0 && down_col_idx <= 7 && down_row_idx >= 0 && down_row_idx <= 7
      current = @columns[down_row_idx][down_col_idx]
      if current == grid && current != nil
        consecutive+=1
      else
        break
      end
      break if consecutive == 4
      down_row_idx+=1
      down_col_idx-=1
    end
    return consecutive == 4
  end

  def left_upper_cross? grid, row_idx, col_idx
    up_col_idx = col_idx
    up_row_idx = row_idx
    consecutive = 0
    while up_col_idx >= 0 && up_col_idx <= 7 && up_row_idx >= 0 && up_row_idx <= 7
      current = @columns[up_row_idx][up_col_idx]
      if current == grid && current != nil
        consecutive+=1
      else
        break
      end
      break if consecutive == 4
      up_row_idx-=1
      up_col_idx-=1
    end
    return consecutive == 4
  end

  def left_lower_cross? grid, row_idx, col_idx
    down_col_idx = col_idx
    down_row_idx = row_idx
    consecutive = 0
    while down_col_idx >= 0 && down_col_idx <= 7 && down_row_idx >= 0 && down_row_idx <= 7
      current = @columns[down_row_idx][down_col_idx]
      if current == grid && current != nil
        consecutive+=1
      else
        break
      end
      break if consecutive == 4
      down_row_idx+=1
      down_col_idx+=1
    end
    return consecutive == 4
  end
end