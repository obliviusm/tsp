module Constants
  def max_population size = 1
    (self.class::SELECTION[:max_population] * @n * size).ceil
  end

  def make_aging?
    self.class::SELECTION[:aging]
  end

  def max_age
    self.class::SELECTION[:max_age]
  end

  def crack_for_bests
    crack = self.class::SELECTION[:crack_for_bests]# - @counter.to_f / 100.0
    #crack < 1 ? 1 : crack
  end

  def select_best_percent
    #percent = self.class::SELECTION[:best_percent] * (1 + @counter.to_f / 10.0)
    #percent > 1 ? 1 : percent
    self.class::SELECTION[:best_percent]
  end

  def wheel_size
    self.class::SELECTION[:wheel_size]
  end

  def selection_type
    self.class::SELECTION[:type]
  end

  def mutation_percent
    self.class::MUTATION[:percent]
  end

  def swap_size
    self.class::MUTATION[:swap_size]
  end

  def mutation_type
    #types = self.class::MUTATION[:mutation_type]
    #steps = self.class::MUTATION[:change_type_steps]
    #choose_type types, steps
    types = self.class::MUTATION[:mutation_type]
    (types.is_a? Array) ? types[0] : types
  end

  def mutation_type_change
    types = self.class::MUTATION[:mutation_type]
    return unless types.is_a? Array

    steps = self.class::MUTATION[:change_type_steps]
    if @counter % steps == 0
      types.rotate!
    end
  end

  def save_best_size
    self.class::RECORD[:save_best_size]
  end

  def hill_climb_record_size
    self.class::RECORD[:hill_climb] * @n
  end

  def reproduction_type
    #types = self.class::REPRODUCTION[:reproduction_type]
    #steps = self.class::REPRODUCTION[:change_type_steps]
    #choose_type types, steps
    types = self.class::REPRODUCTION[:reproduction_type]
    (types.is_a? Array) ? types[0] : types
  end

  def reproduction_change_type
    types = self.class::REPRODUCTION[:reproduction_type]
    return unless types.is_a? Array
    change_type = self.class::REPRODUCTION[:change_type]
    return unless change_type == :cyclic

    steps = self.class::REPRODUCTION[:change_type_steps]
    if @counter % steps == 0
      types.rotate!
    end
  end

  def choose_type types, steps
    if types.is_a? Array
      if @counter.to_i % steps == 0
        types.rotate!
      end 
      types[0]
    else
      types
    end
  end

  def iterations
    self.class::STOP_CRITERIA[:iterations] * @n
  end

  def max_steps_without_improving
    #self.class::STOP_CRITERIA[:max_steps_without_improving]
    @n * 2
  end

  def stop_criteria_type
    self.class::STOP_CRITERIA[:type]
  end
end