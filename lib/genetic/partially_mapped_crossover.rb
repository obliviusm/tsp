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
    copy_gap
    for i in 0..@n
      @x[i] = next_x(i) unless @x[i]
      #p @x
    end
    @x
  end

  protected

  def copy_gap
    for i in 0..@n
      @x[i] = @x1[i] if in_gap?(i)
    end
  end

  def next_x(i)
    begin 
      x_i = @x2[i]
      if @x.include?(x_i)
        i = @x1.index(x_i)
      end
    end while @x.include?(x_i)
    x_i
  end

  def in_gap? i
    @k <= i && i <= @k + @m
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