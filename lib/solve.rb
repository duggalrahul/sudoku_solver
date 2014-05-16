class SudokuSolver
  attr_reader :grid

  def initialize()
    @grid = Grid.new()
  end

  def solve_brute_force
    cell_index, cell = @grid.first
    until cell.nil?
      cell_value = cell.increment
      unless cell_value == false
        if @grid.value_allowed?(cell_index, cell_value)
          cell.increment!
          cell_index, cell = @grid.next(cell_index)
        else
          cell.increment!
        end
      else
        cell.empty!
        cell_index, cell = @grid.pred(cell_index)
      end
    end
  end

  # Class implements methods for easier manipulation with grid
  class Grid
    attr_reader :size
    attr_reader :sub_size

    def initialize()
      @size = 0
      @sub_size = 0
      #@rows = Array.new(4)
    end

    def cell_at(cell_index)
      @rows[cell_index / @size.to_i][cell_index % @size.to_i]
    end

    def convert_to_grid(string_sudoku)
      
      @temp = Array.new
      string_sudoku.each_char do |c|
          @temp.push(c.to_i)
        end
            
      len = string_sudoku.length
      sqr = Math.sqrt(len).to_i
      @row = Array.new(sqr){Array.new}

      @temp.each_with_index do |val,ind|
          value = val.to_i
          if value > 0
              @row[ind/sqr].push(Cell.new(value,9,true))
          else
              @row[ind/sqr].push(Cell.new(nil,9))
          end
        end

      @rows = @row
      @size = @rows.count
      @sub_size = Math.sqrt(@size)
    end

    def first
      (0..(@size*@size-1)).each do |index|
        return index, cell_at(index) unless cell_at(index).predefined?
      end
      nil
    end

    def next(cell_index)
      (cell_index+1..(@size*@size-1)).each do |index|
        return index, cell_at(index) unless cell_at(index).predefined?
      end
      return nil, nil
    end

    def pred(cell_index)
      (0..cell_index-1).reverse_each do |index|
        return index, cell_at(index) unless cell_at(index).predefined?
      end
      return nil, nil
    end

    def value_allowed?(cell_index, value)
      row_index = cell_index / @size.to_i
      column_index = cell_index % @size.to_i
      return false if row_contains_value?(row_index, value)
      return false if column_contains_value?(column_index, value)
      return false if subgrid_contains_value?(row_index, column_index, value)
      true
    end

    def row_contains_value?(row_index, value)
      (0..@size-1).each do |column_index|
        return true if @rows[row_index][column_index].value == value
      end
      false
    end

    def column_contains_value?(column_index, value)
      (0..@size-1).each do |row_index|
        return true if @rows[row_index][column_index].value == value
      end
      false
    end

    def subgrid_contains_value?(row_index, column_index, value)
      start_row_index = row_index - (row_index % @sub_size)
      start_column_index = column_index - (column_index % @sub_size)
      end_row_index = start_row_index + @sub_size - 1
      end_column_index = start_column_index + @sub_size - 1
      @rows[start_row_index..end_row_index].each do |row|
        row[start_column_index..end_column_index].each do |cell|
          return true if cell.value == value
        end
      end
      false
    end

    def to_s
      output = ''
      @rows.each do |row|
        output += row.collect { |column| column.to_s }.join('') #+ "\n"
      end
      return output      
    end

    # Class represents one cell in sudoku grid
    class Cell
      attr_accessor :value
      attr_reader :predefined

      def initialize(value, max_value = 9, predefined = false)
        @max_value = max_value
        @value = value
        @predefined = predefined
      end

      def predefined?
        @predefined
      end

      def empty?
        @value.nil? ? true : false
      end

      def empty!
        @value = nil
      end

      def to_s
        empty? ? '?' : @value.to_s
      end

      def increment
        if empty?
          1
        else
          if @value == @max_value
            false
          else
            @value.next
          end
        end
      end

      def increment!
        @value = self.increment
      end
    end

  end

end

# sudoku = SudokuSolver.new
# #sudoku.grid.convert_to_grid('0010020030000001')
# sudoku.grid.convert_to_grid('530070000600195000098000060800060003400803001700020006060000280000419005000080079')

# sudoku.solve_brute_force
# puts sudoku.grid.to_s