class SmoothingAlgorithm
  extend SingleSolutionBased
  include SmoothMatrix
  attr_reader :solution
  ALFAS = [12, 6, 3, 2, 1].freeze

  def initialize w, x
    @solution = TSPSolution.new(w, x) # is used in SolveWithTimer
    @w = w
  end

  def solve
    initial_solution = @solution.dup
    ALFAS.each do |alfa|
      w_smoothed = smooth_matrix alfa
      smoothed_solution = HillClimbing.new(w_smoothed, initial_solution.x).solve
      new_solution = HillClimbing.new(@w, smoothed_solution.x).solve
      update_record_if_needed new_solution
    end
  end

  protected

  def update_record_if_needed new_solution
    if new_solution < @solution
      @solution = new_solution
    end
  end
end