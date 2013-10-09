class RolloutMock
  def active?(feature)
    true
  end
end

$rollout  = RolloutMock.new
