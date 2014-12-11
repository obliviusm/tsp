module Crossover
  def cycle_x solution
    x_new = CycleCrossover.new(self, solution).crossover
    TSPSolution.new(w, x_new)
  end

  def max_preservative_x solution
    x_new = MaxPreservativeX.new(self, solution).crossover
    TSPSolution.new(w, x_new)
  end

  def partially_mapped_x solution
    x_new = PartiallyMappedX.new(self, solution).crossover
    TSPSolution.new(w, x_new)
  end
end