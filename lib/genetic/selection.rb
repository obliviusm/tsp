module Selection
  def selection params
    delete_infinity
    aging if params[:aging]
    @population = if params[:best_percent]
                    select_partially_random
                  elsif params[:random_bests]
                    select_random_from_bests
                  else
                    select
                  end
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
end