module Mutation
  def extential_mutation
    begin
      mutation
    end while @population.size < max_population
  end

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