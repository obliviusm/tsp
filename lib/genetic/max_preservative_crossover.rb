class MaxPreservativeX
  def initialize solution1, solution2
    @x1, @x2 = solution1.x.dup, solution2.x.dup #parents
    @f1, @f2 = solution1.f, solution2.f
    @n = solution1.n
    @x = []
    @k = set_random_k
  end

  def crossover
    copy_x1_first_part
    remove_elements_from_x2
    copy_x2_second_part
    @x
  end

  protected

  def set_random_k
    shift = (@n/2).floor
    (shift/2).floor + rand(shift)
  end

  def copy_x1_first_part
    @x.concat @x1.slice(0,@k)
  end

  def remove_elements_from_x2
    @x2 = @x2 - @x
  end

  def copy_x2_second_part
    @x.concat @x2
  end
end