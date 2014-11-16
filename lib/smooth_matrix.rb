module SmoothMatrix
  def smooth_matrix alfa
    @w.map{|row| row.map{|el| smooth_distance el, alfa }}
  end

  def smooth_distance d, alfa
    if d >= average
      average + (d - average)**(1.0/alfa)
    else
      average - (average - d)**(1.0/alfa)
    end
  end

  def average
    unless @w_average
      w_flatten = @w.flatten.delete_if{|d| d == Float::INFINITY }
      @w_min = w_flatten.min
      @w_average = w_flatten.reduce(:+).to_f / w_flatten.size
    end
    @w_average
  end
end