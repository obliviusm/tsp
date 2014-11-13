module Timer
  def self.exec_time
    start = Time.now
    yield
    Time.now - start
  end
end