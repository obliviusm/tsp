module Selection
  def selection
    delete_infinity
    #remove_duplication
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

  def select_probability_wheel shuffle = false
    probability_wheel = fill_probability_wheel
    population_indices =  unless shuffle
                            pull_solutions_from_wheel probability_wheel
                          else
                            shuffle_solutions_from_wheel probability_wheel
                          end
    population_indices.map{ |i| @population[i] }
  end
  
  #def shuffle_solutions_from_wheel2 probability_wheel
    
  #end
  
  def shuffle_solutions_from_wheel probability_wheel
    new_population = []
    size = wheel_size || 1
    probability_wheel.shuffle!
    begin
      new_population += probability_wheel.pop(max_population size)
      new_population.uniq!
    end while new_population.length < max_population(size)
    new_population.first max_population(size)
  end

  def pull_solutions_from_wheel probability_wheel
    new_population = []
    begin
      next_num = rand probability_wheel.length
      next_sol = probability_wheel[next_num]
      new_population.push probability_wheel.delete(next_sol)
      #p new_population.size
    end while new_population.length < max_population
    new_population
  end

  def fill_probability_wheel
    probability_wheel = []
    max_f = @population.max.f + 1
    @population.shuffle.each_with_index do |sol, i|#.first(max_population crack_for_bests)
      times = (max_f - sol.f).to_i
      probability_wheel += Array.new(times, i)
      #(max_f - sol.f).to_i.times do
      #  probability_wheel.push i
      #end
    end
    probability_wheel
  end

  def select_partially_random
    new_population = select_random_from_bests select_best_percent
    @population -= new_population
    new_population += @population.shuffle.first(max_population 1 - select_best_percent)
    new_population
  end

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

  def delete_infinity
    @population = @population.delete_if { |sol| sol.f == Float::INFINITY }
  end

  def aging
    @population = @population
                    .each{ |sol| sol.grow_up }
                    .keep_if{ |sol| sol.age < max_age }
  end

  def remove_duplication
    @population = @population.delete_tsp_diplicates
  end
end