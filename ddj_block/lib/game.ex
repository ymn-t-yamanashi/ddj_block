defmodule Game do
  @doc """
  Collided detection.

  ## Examples

      iex> Game.collided?(1, 1, 10, 10, 5, 5, 5, 5)
      true

  """
  def collided?(x1, y1, w1, h1, x2, y2, w2, h2) do
    x1 <= x2 + w2 && x1 + w1 >= x2 && y1 <= y2 + h2 && y1 + h1 >= y2
  end

  def collided?(x1, y1, w1, h1, judgments) do
    judgments
    |> Enum.map(fn judgement ->
      [x2, y2, w2, h2] = judgement
      collided?(x1, y1, w1, h1, x2, y2, w2, h2)
    end)
    |> Enum.any?()
  end

  def collided_with_filter(x1, y1, w1, h1, judgments) do
    judgments =
      judgments
      |> Enum.map(fn judgement ->
        [x2, y2, w2, h2] = judgement
        [collided?(x1, y1, w1, h1, x2, y2, w2, h2), judgement]
      end)

    collided =
      judgments
      |> Enum.any?(fn [x, _] -> x end)

    judgments =
      judgments
      |> Enum.filter(fn [x, _] -> !x end)
      |> Enum.map(fn [_, x] -> x end)

    {collided, judgments}
  end
end
