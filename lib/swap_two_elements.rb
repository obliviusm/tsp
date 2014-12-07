module SwapTwoElements
  def swap i, j
    i0, i1, i2 = x[i - 1], x[i], x[i + 1]
    j0, j1, j2 = x[j - 1], x[j], x[j + 1]
    j2 = x[0] if j == n 
    #p [@n, i, j, i0, i1, i2, j0, j1, j2]
    delta = 0
    if i == 0 && j == n
      delta = (w[j0][i1] + w[i1][j1] + w[j1][i2]) -(w[j0][j1] + w[j1][i1] + w[i1][i2])
    else
      if j - i == 1
        delta = (w[i1][j2] + w[j1][i1]) - (w[i1][j1] + w[j1][j2])
      else
        delta = (w[j0][i1] + w[i1][j2] + w[j1][i2]) - (w[i1][i2] + w[j0][j1] + w[j1][j2])
      end
      delta += w[i0][j1] - w[i0][i1]
    end
    
    TSPSolution.new w, swap_path(i, j), f + delta
  end

  def swap_path i, j
    x_copy = x.dup
    x_copy[i], x_copy[j] = x_copy[j], x_copy[i]
    x_copy
  end
end