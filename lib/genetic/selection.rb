module Selection
  def selection
    delete_infinity
    remove_duplication
    aging if make_aging?
    @population = case selection_type
                  when :best_percent
                    select_partially_random
                  when :random_bests
                    select_random_from_bests
                  when :probability_wheel
                    select_probability_wheel
                  when :shuffle_probability_wheel
                    select_probability_wheel true
                  else
                    select
                  end
  end
#
# => Hybrid selections
#
  def select_partially_random
    new_population = select select_best_percent
    @population -= new_population
    new_population += select_probability_wheel true, (1 - select_best_percent)
    new_population
  end

#
# => Probability wheel
#
  def select_probability_wheel shuffle = false, size = 1
    return [] if @population.empty?

    probability_wheel = fill_probability_wheel
    population_indices =  unless shuffle
                            pull_solutions_from_wheel probability_wheel, size
                          else
                            shuffle_solutions_from_wheel probability_wheel, size
                          end
    population_indices.map{ |i| @population[i] }
  end
  
  def shuffle_solutions_from_wheel probability_wheel, size = 1
    new_population = []
    probability_wheel.shuffle!
    begin
      new_population.concat probability_wheel.pop(max_population size)
      new_population.uniq!
    end while new_population.length < max_population(size) && probability_wheel.length > 0
    new_population.first max_population(size)
  end

  def pull_solutions_from_wheel probability_wheel, size = 1
    new_population = []
    begin
      next_num = rand probability_wheel.length
      next_sol = probability_wheel[next_num]
      new_population.push probability_wheel.delete(next_sol)
    end while new_population.length < max_population(size) && probability_wheel.length > 0
    new_population.first max_population(size)
  end

  def fill_probability_wheel
    probability_wheel = []
    max_f = @population.max.f + 1
    @population.shuffle.each_with_index do |sol, i|
      times = (max_f - sol.f).to_i
      probability_wheel += Array.new(times, i)
    end
    probability_wheel
  end
#
# => Pure selection methods
#
  def select_random_from_bests size = 1
    @population
      .sort
      .first(max_population crack_for_bests)
      .shuffle
      .first(max_population size)
      .sort
  end

  def select size = 1
    @population
      .sort
      .first(max_population size)
  end
#
# => Helpers for cleaning population
#
  def delete_infinity
    @population = @population.delete_if { |sol| sol.f == Float::INFINITY }
  end

  def aging
    @population = @population
                    .each{ |sol| sol.grow_up }
                    .keep_if{ |sol| sol.age < max_age }
  end

  def remove_duplication
    if @counter.to_i % 10 == 0
      @population = @population.delete_tsp_diplicates
    end
  end
end