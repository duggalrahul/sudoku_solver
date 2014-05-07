require 'try'
class SolversController < ApplicationController


  protect_from_forgery :except => :create
  
  # GET /solvers
  # GET /solvers.xml
  def index
    @solvers = Solver.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @solvers }
    end
  end

  # GET /solvers/1
  # GET /solvers/1.xml
  def show
    @solver = Solver.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @solver }
    end
  end

  # GET /solvers/new
  # GET /solvers/new.xml
  def new
    @solver = Solver.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @solver }
    end
  end

  # GET /solvers/1/edit
  def edit
    @solver = Solver.find(params[:id])

  end
  
  def create    
    #@solver = Hash.new{|hash, key| hash[key] = Hash.new}
    @solver = String.new()
    for row in 'a'..'i'
      for col in 0..8
        @solver.concat(params[:solver][row+col.to_s])
      end
    end
    
    #@size = @solver.length
    #make a new sudokusolver object
    sudoku = SudokuSolver.new()
    sudoku.grid.convert_to_grid(@solver.to_s)
    sudoku.solve_brute_force
    @solution = sudoku.grid.to_s
    
  end

  # PUT /solvers/1
  # PUT /solvers/1.xml
  def update
    @solver = Solver.find(params[:id])

    respond_to do |format|
      if @solver.update_attributes(params[:solver])
        format.html { redirect_to(@solver, :notice => 'Solver was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @solver.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /solvers/1
  # DELETE /solvers/1.xml
  def destroy
    @solver = Solver.find(params[:id])
    @solver.destroy

    respond_to do |format|
      format.html { redirect_to(solvers_url) }
      format.xml  { head :ok }
    end
  end
end
