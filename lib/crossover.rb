module Crossover
  def cycle_x solution
    x1, x2 = x.dup, solution.x.dup
    f1, f2 = f, solution.f

    c = build_cycles_mask x1, x2
    x_new = build_new_x c, [x1, x2], f1, f2
    TSPSolution.new(w, x_new)
  end

  def build_new_x c, x_gen, f1, f2
    x_new = []
    mask = []

    (0..c.max).each do |i|
      num = rand (f1 + f2)
      mask[i] = num < f1 ? 0 : 1
    end

    c.each_with_index do |val, i|
      x_num = mask[val]
      x_new[i] = x_gen[x_num][i]
    end
    x_new
  end

  def build_cycles_mask x1, x2
    c = []
    (0..@n).each do |i|
      next if c[i]
      indices = build_cycle i, x1, x2
      cycle_num = (c.compact.max || -1) + 1
      indices.each{ |index| c[index] = cycle_num}
    end
    c
  end

  # i - first element in cycle
  def build_cycle i, x1, x2
    indices = []
    loop do
      indices.push i
      val = x1[i]
      i = x2.index val
      break if indices.include? i
    end
    indices
  end
end