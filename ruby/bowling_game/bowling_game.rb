class BowlingGame
  def initialize
    @rolls = []
  end

  def roll(pins)
    @rolls << pins
  end

  def score
    max_index = @rolls.length
    roll(0)
    roll(0)

    score = 0
    frame_index = 0

    10.times do
      if strike?(frame_index)
        score += strike_score(frame_index)
        frame_index += 1
      elsif spare?(frame_index)
        score += spare_score(frame_index)
        frame_index += 2
      else
        score += @rolls[frame_index] + @rolls[frame_index + 1]
        frame_index += 2
      end
    end

    score
  end

  private

  def strike?(frame_index)
    @rolls[frame_index] == 10
  end

  def spare?(frame_index)
    @rolls[frame_index] + @rolls[frame_index + 1] == 10
  end

  def strike_score(frame_index)
    10 + @rolls[frame_index + 1] + @rolls[frame_index + 2]
  end

  def spare_score(frame_index)
    10 + @rolls[frame_index + 2]
  end

end
