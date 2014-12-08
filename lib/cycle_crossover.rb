class CycleCrossover
  def initialize solution1, solution2
    @x1, @x2 = solution1.x.dup, solution2.x.dup #parents
    @f1, @f2 = solution1.f, solution2.f
    @c = []
    @n = solution1.n
    @x = [] # child
  end

  def crossover
    build_cycles_mask
    p @c.max
    build_x
    #p @x1, @x2, @c, @x
    #fdfd
  end

  protected

  def build_x
    x_gen = [@x1, @x2]
    
    mask = divide_cycles

    @c.each_with_index do |val, i|
      x_num = mask[val]
      @x[i] = x_gen[x_num][i]
    end
    @x
  end

  def divide_cycles
    mask = []
    (0..@c.max).each do |i|
      num = rand (@f1 + @f2)
      mask[i] = num < @f1 ? 0 : 1
    end
    mask
  end

  def build_cycles_mask
    (0..@n).each do |i|
      next if @c[i]
      indices = build_cycle i
      cycle_num = (@c.compact.max || -1) + 1
      indices.each{ |index| @c[index] = cycle_num}
    end
  end

  # i - first element in cycle
  def build_cycle i
    indices = []
    loop do
      indices.push i
      val = @x1[i]
      i = @x2.index val
      break if indices.include? i
    end
    indices
  end
end