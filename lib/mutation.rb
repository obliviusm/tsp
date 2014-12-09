module Mutation
  def mutation
    mutant = @population.shuffle.percent_elements(mutation_percent).map do |sol|
      sol.swap_random 3
    end
    @population += mutant
  end
end