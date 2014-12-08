require_relative "../lib/tsp_solution"
require_relative "../lib/population_based"
require_relative "../lib/array_percent"
require_relative "hill_climbing"

class GeneticAlgorithm
  extend PopulationBased
  attr_reader :solution

  MUTATION_PERCENT = 5
  ITERATIONS = 10
  MAX_POPULATION = 30
  BEST_PERCENT = 5

  def initialize w, paths
    @population = (TSPSolution.new_array w, paths).sort
    @solution = @population.min
    @n = @solution.n
  end

  def solve
    extential_reproduction
    make_hill_climb_for_bests
    begin 
      saving_reproduction
      mutation
      make_hill_climb_for_bests
      selection
    end while stop_criteria
    make_hill_climb_for_bests
  end

  protected

  def make_hill_climb_for_bests
    best_climbers = @population.sort.first(BEST_PERCENT).map do |sol|
      HillClimbing.new(sol.w, sol.x).solve
    end
    update_record best_climbers.min
  end

  def extential_reproduction
    begin
      saving_reproduction
    end while max_population > @population.length
  end

  def killing_reproduction
    @population = reproduction # goodbye parents
  end

  def saving_reproduction
    @population += reproduction
  end

  def reproduction
    children = []
    @population.shuffle.each_slice(2) do |sol1, sol2|
      if sol1 && sol2
        children.push sol1.cycle_x(sol2)
        children.push sol2.cycle_x(sol1)
      end
    end
    children
  end

  def mutation
    mutant = @population.shuffle.percent_elements(MUTATION_PERCENT).map do |sol|
      sol.swap_random 3
    end
    @population += mutant
  end

  def selection
    @population = @population
      .delete_if { |sol| sol.f == Float::INFINITY } \
      #.delete_tsp_diplicates
      .sort
      .first(max_population)
      #.shuffle
      #.first(max_population)
      #sort
  end

  def stop_criteria
    @counter ||= 0
    @counter += 1
    @counter < ITERATIONS * @n
  end

  def update_record candidate = nil
    candidate ||= @population.min
    @solution = candidate if candidate < @solution
  end

  def max_population 
    MAX_POPULATION * @n
  end
end