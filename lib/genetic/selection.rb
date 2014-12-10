module Selection
  def selection params
    delete_infinity
    aging if params[:aging]
    @population = if params[:partially_random]
                    select_partially_random
                  elsif params[:crack_size]
                    select_random_from_bests
                  else
                    select
                  end
  end

  def select_partially_random
    #new_population = select 1 - partially_random
    #@population -= new_population
    new_population = select_random_from_bests.first(max_population partially_random)
    @population -= new_population
    new_population += @population.shuffle.first(max_population 1 - partially_random)
    new_population
  end

  def select_random_from_bests
    @population
      .sort
      .first(max_population crack_size)
      .shuffle
      .first(max_population)
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