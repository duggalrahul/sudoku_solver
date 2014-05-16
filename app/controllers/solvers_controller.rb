require 'solve'
require 'timeout'
class SolversController < ApplicationController


  protect_from_forgery :except => :create
  
  
  $sudoku = SudokuSolver.new()
  
  # GET /solvers
  # GET /solvers.xml
  def index
    render 'index.html.erb'
    
  end

  # GET /solvers/1
  # GET /solvers/1.xml
  def show
    
    $sudoku.grid.convert_to_grid(@solver.to_s)
    Timeout::timeout(5){$sudoku.solve_brute_force 
      @solution = $sudoku.grid.to_s
      render 'show.html.erb'}
    rescue Timeout::Error
      @solution = 'Taking too much time'  
      render 'show.html.erb'   
  end

  # GET /solvers/new
  # GET /solvers/new.xml
  def new
    render 'new.html.erb'
    
  end

  # GET /solvers/1/edit
  def edit

  end
  
  def create    
    #@solver = Hash.new{|hash, key| hash[key] = Hash.new}
    @solver = String.new()
    for row in 'a'..'i'
      for col in 0..8
        @solver.concat(params[:solver][row+col.to_s])
      end
    end    

    show


  end

  # PUT /solvers/1
  # PUT /solvers/1.xml
  def update

  end

  # DELETE /solvers/1
  # DELETE /solvers/1.xml
  def destroy
   
  end
end
