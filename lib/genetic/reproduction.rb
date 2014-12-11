module Reproduction
  def extential_reproduction
    begin
      saving_reproduction
    end while max_population > @population.length
  end

  def killing_reproduction
    @population = reproduction + @population.sort.first(1)
  end

  def saving_reproduction
    @population += reproduction
  end

  def reproduction
    children = []
    @population.shuffle.each_slice(2) do |sol1, sol2|
      if sol1 && sol2
        children.push sol1.cycle_x(sol2)
        children.push sol2.cycle_x(sol1)
      end
    end
    children
  end
end