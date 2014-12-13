module Mutation
  def extential_mutation
    begin
      mutation
    end while @population.size < max_population
  end

  def mutation
    mutant =  population_for_mutation do |sol|
                case mutation_type
                when :hill_climbing
                  HillClimbing.new(sol.w, sol.x).solve
                else
                  sol.swap_random swap_size
                end
              end
    @population += mutant
  end

  def population_for_mutation
    @population
      .shuffle
      .percent_elements(mutation_percent)
      .map do |sol|
        yield sol
      end
  end
end