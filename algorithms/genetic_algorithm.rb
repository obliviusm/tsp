require_relative "../lib/tsp_solution"
require_relative "../lib/population_based"
require_relative "../lib/array_percent"
require_relative "../lib/reproduction"
require_relative "../lib/record_handling"
require_relative "../lib/selection"
require_relative "../lib/mutation"
require_relative "hill_climbing"

class GeneticAlgorithm
  include Reproduction
  include RecordHandling
  include Selection
  include Mutation
  extend PopulationBased
  attr_reader :solution

  MUTATION_PERCENT = 5
  ITERATIONS = 10
  MAX_POPULATION = 50
  BEST_PERCENT = 5
  MAX_AGE = 5
  CRACK_SIZE = 2

  def initialize w, paths
    @population = (TSPSolution.new_array w, paths).sort
    @solution = @population.min
    @n = @solution.n
  end

  def solve
    extential_reproduction
    #make_hill_climb_for_bests
    begin 
      saving_reproduction
      mutation
      save_best
      #make_hill_climb_for_bests
      selection aging: true, crack_size: CRACK_SIZE
    end while stop_criteria
    make_hill_climb_for_bests
  end

  protected

  def stop_criteria
    @counter ||= 0
    @counter += 1
    @counter < ITERATIONS * @n
  end

  def max_population size = 1
    (MAX_POPULATION * @n * size).ceil
  end

  def mutation_percent
    MUTATION_PERCENT
  end

  def max_age
    MAX_AGE
  end

  def best_percent
    BEST_PERCENT
  end
end