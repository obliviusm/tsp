module Neighborhood
  def neighborhood shuffle = false
    indices = swap_indices
    indices.shuffle! if shuffle 
    indices.each do |i, j|
      yield @solution.swap(i, j)
    end
  end
  
  def swap_indices
    unless @swap_indices
      set_swap_indices
    end
    @swap_indices
  end
  
  def set_swap_indices
    @swap_indices = []
    for i in 0...@n
      for j in (i + 1)..@n
        @swap_indices.push [i, j]
      end
    end
  end
end