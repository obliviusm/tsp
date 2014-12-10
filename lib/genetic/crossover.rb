module Crossover
  def cycle_x solution
    x_new = CycleCrossover.new(self, solution).crossover
    TSPSolution.new(w, x_new)
  end
end