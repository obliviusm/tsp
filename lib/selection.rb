module Selection
  def selection params
    aging if params[:aging]
    @population = if params[:crack_size]
                    select_partially_random params[:crack_size]
                  else
                    select
                  end
  end

  def aging
    #p @population.size
    @population = @population
                    .each{ |sol| sol.grow_up }
                    .keep_if{ |sol| sol.age < max_age }
    #p @population.size
    #p @population.map{|sol| sol.age}
  end

  def select_partially_random crack_size
    @population
      .delete_if { |sol| sol.f == Float::INFINITY } \
      #.delete_tsp_diplicates
      .sort
      .first(max_population crack_size)
      .shuffle
      .first(max_population)
      .sort
  end

  def select
    @population
      .delete_if { |sol| sol.f == Float::INFINITY } \
      .sort
      .first(max_population)
  end
end