class GeneticBase
  include Reproduction
  include RecordHandling
  include Selection
  include Mutation
  include Constants
  extend PopulationBased
  attr_reader :solution

  def initialize w, paths
    @population = (TSPSolution.new_array w, paths).sort
    @solution = @population.min
    @n = @solution.n
  end

  protected

  def stop_criteria
    @counter ||= 0
    @counter += 1
    @counter < iterations
  end
end