module Mutation
  def mutation
    mutant = @population
                .shuffle
                .percent_elements(mutation_percent)
                .map do |sol|
                  sol.swap_random swap_size
                end
    @population += mutant
  end
end