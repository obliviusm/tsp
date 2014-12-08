module XComparator
  def x_unified
    unless @x_unified
      index0 = @x.index(0)
      @x_unified = @x[index0..@n] + @x[0...index0]
    end
    @x_unified
  end
end