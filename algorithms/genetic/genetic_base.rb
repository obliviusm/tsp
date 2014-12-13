class GeneticBase
  include Reproduction
  include RecordHandling
  include Selection
  include Mutation
  include Constants
  include StopCriteria
  extend PopulationBased
  attr_reader :solution

  def initialize w, paths
    @population = (TSPSolution.new_array w, paths).sort
    @solution = @population.min
    @n = @solution.n
  end
end