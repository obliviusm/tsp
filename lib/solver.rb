require_relative "../lib/tsp_solved_data"
require_relative "../services/timer"

class Solver
  def initialize graph, algorithm, initial_solutions
    @graph = graph
    @algorithm = algorithm
    @initial_solutions = initial_solutions
  end

  def solve
    if @algorithm.is_population_based?
      solve_population 
    elsif @algorithm.is_single_solution_based?
      solve_single
    end
  end

  protected

  def solve_population
    solve_with_timer @initial_solutions
  end

  def solve_single
    tsp_data = @initial_solutions.map do |init_sol|
      solve_with_timer init_sol
    end
    @tsp_best = tsp_data.min
    @tsp_best
  end

  def solve_with_timer start_solution
    algorithm = @algorithm.new(@graph, start_solution)
    time = Timer.exec_time do
      algorithm.solve
    end
    solution = algorithm.solution
    TSPSolvedData.new(initial_tsp_solutions, solution, time)
  end

  def initial_tsp_solutions
    unless @initial_tsp_solutions
      @initial_tsp_solutions = @initial_solutions.map do |solution_path|
        TSPSolution.new(@graph, solution_path)
      end
    end
    @initial_tsp_solutions
  end
end