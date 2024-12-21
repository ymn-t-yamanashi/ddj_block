defmodule Block do
  def main(nil) do
    blocks =
      1..3
      |> Enum.flat_map(fn y -> creat_blocks(y) end)
      |> IO.inspect()

    %{
      wall: [
        [0.0, 0.0, 10.0, 800.0],
        [790.0, 0.0, 10.0, 800.0],
        [0.0, 0.0, 800.0, 10.0]
      ],
      blocks: blocks,
      player: [[350.0, 790.0, 100.0, 10.0]],
      ball: [[350.0, 400.0, 5.0, 5.0]]
    }
  end

  def main(%{} = data) do
    data
  end

  def creat_blocks(y) do
    1..5
    |> Enum.map(fn x ->
      [120.0 * x, 100.0 * y, 100.0, 50.0]
    end)
  end
end
