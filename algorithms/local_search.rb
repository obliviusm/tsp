require_relative "../lib/tsp_solution"
class LocalSearch
  def initialize w, x
    @solution = TSPSolution.new(w, x)
    @n = @solution.n
  end
  
  def f
    @solution.f
  end
  
  def simple_local_search
    begin 
      found_new_solution = false
      neighborhood(true) do |solution_new|
        if solution_new < @solution
          @solution = solution_new
          found_new_solution = true
          break
        end
      end
    end while found_new_solution
    @solution
  end
  
  protected
  
  def neighborhood shuffle = false
    indices = swap_indices
    #indices.shuffle! if shuffle 
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