require_relative "../lib/tsp_solution"
require_relative "../lib/population_based"
require_relative "../lib/array_percent"
require_relative "hill_climbing"

class GeneticAlgorithm
  extend PopulationBased
  attr_reader :solution

  MUTATION_PERCENT = 5
  ITERATIONS = 10
  MAX_POPULATION = 20

  def initialize w, paths
    @population = TSPSolution.new_array w, paths
    @solution = @population.min
    @n = @solution.n
  end

  def solve
    begin 
      reproduction
      mutation
      selection
      update_record
    end while stop_criteria
    make_hill_climb
  end

  protected

  def make_hill_climb
    @solution  = HillClimbing.new(@solution.w, @solution.x).solve
  end

  def reproduction
    children = []
    @population.shuffle.each_slice(2) do |sol1, sol2|
      children.push sol1.cycle_x(sol2) if sol1 && sol2
    end
    @population += children
  end

  def mutation
    mutant = []
    @population.shuffle.percent_elements(MUTATION_PERCENT).each do |sol|
      mutant.push sol.swap_random
    end
    @population += mutant
  end

  def selection
    @population = @population.sort.first(MAX_POPULATION * @n).delete_if do |sol|
      sol.f == Float::INFINITY
    end
  end

  def stop_criteria
    @counter ||= 0
    @counter += 1
    @counter < ITERATIONS * @n
  end

  def update_record
    new_record = @population.min
    @solution = new_record if new_record < @solution
  end
end