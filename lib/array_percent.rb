class Array
  def percent_elements(percent)
    take((size * percent / 100.0).ceil)
  end

  def delete_tsp_diplicates
    paths = []
    new_array = []
    self.each do |tsp|
      x_unified = tsp.x_unified
      unless paths.include? x_unified
        paths.push x_unified
        new_array.push tsp
      end
    end
    new_array
  end

  def tsp_avg_f
    sum = self.inject(0) do |sum, x|
      sum + (x.f != Float::INFINITY ? x.f : 0)
    end
    sum / self.size
  end
end