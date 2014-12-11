class PartiallyMappedX
  def initialize solution1, solution2
    @x1, @x2 = solution1.x.dup, solution2.x.dup #parents
    @f1, @f2 = solution1.f, solution2.f
    @n = solution1.n
    @x = []
    @m = set_random_gap_size
    @k = set_random_gap_position
  end

  def crossover
    for i in 0..@n
      @x.push next_x(i)
    end
    p @x
    @x
  end

  protected

  def next_x(i)
    x_i = (in_gap?(i) || rand_f) ? @x1[i] : @x2[i]
    @x1.delete x_i
    @x2.delete x_i

    x_i
  end

  def in_gap? i
    @k <= i && i <= @k + @m
  end

  def rand_f
    rand(@f1+@f2) > @f1
  end

  def set_random_gap_size
    min_gap_size + rand(max_gap_size)
  end

  def min_gap_size
    2
  end

  def max_gap_size
    (@n / 4).floor
  end

  def set_random_gap_position
    @m + rand(@n - @m)
  end 
end