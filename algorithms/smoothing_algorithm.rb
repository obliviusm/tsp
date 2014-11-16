require_relative "../lib/solve_with_timer"
require_relative "../lib/smooth_matrix"
require_relative "hill_climbing"

class SmoothingAlgorithm
  include SolveWithTimer
  include SmoothMatrix
  ALFAS = [6, 3, 2, 1].freeze

  def initialize w, x
    @solution = TSPSolution.new(w, x) # is used in SolveWithTimer
    @w = w
  end

  def algorithm
    initial_solution = @solution.dup
    ALFAS.each do |alfa|
      w_smoothed = smooth_matrix alfa
      smoothed_solution = HillClimbing.new(w_smoothed, initial_solution.x).algorithm
      new_solution = HillClimbing.new(@w, smoothed_solution.x).algorithm
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