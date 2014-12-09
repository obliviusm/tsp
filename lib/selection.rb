module Selection
  def selection params
    delete_infinity
    aging if params[:aging]
    @population = if params[:crack_size]
                    select_random_from_bests params[:crack_size]
                  elsif params[:partially_random]
                    select_partially_random params[:partially_random]
                  else
                    select
                  end
  end

  def select_partially_random random_part
    new_population = select 1 - random_part
    new_population += @population.shuffle.first(max_population random_part)
    new_population
  end

  def select_random_from_bests crack_size
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