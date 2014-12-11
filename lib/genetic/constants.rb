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
    percent = self.class::SELECTION[:best_percent] * (1 + @counter.to_f / 10.0)
    percent > 1 ? 1 : percent
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

  def iterations
    self.class::ITERATIONS * @n
  end

  def save_best_size
    self.class::RECORD[:save_best_size]
  end

  def hill_climb_record_size
    self.class::RECORD[:hill_climb] * @n
  end
end