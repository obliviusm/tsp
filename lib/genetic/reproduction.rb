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
        children.concat reproduct(sol1, sol2)
      end
    end
    children
  end

  def reproduct(sol1, sol2)
    [[sol1, sol2], [sol2, sol1]].map do |s1, s2|
      s1.send(reproduction_type, s2)
    end
  end
end