defmodule DdjBlock do
  @moduledoc """
  Documentation for `DdjBlock`.
  """
  alias Rayex.Structs.Rectangle
  use Rayex

  def main() do
    Task.async(fn -> ddj() end)
    t = Task.async(fn -> maing() end)
    Task.await(t , 500000)
  end

  defp ddj() do
    {_, input} = PortMidi.open(:input, "DDJ-FLX4 MIDI 1")
    PortMidi.listen(input, self())
    midi_in(input)
    PortMidi.close(:input, input)
  end

  defp maing() do
    init_window(800, 800, "DdjBlock")
    main_loop(true)
  end

  defp main_loop(true) do
    begin_drawing()
    draw()
    end_drawing()

    Process.sleep(100)
    main_loop(!window_should_close())
  end

  defp main_loop(_), do: nil

  defp draw() do
    rectangle = %Rectangle{x: 100.0, y: 100.0, width: 100.0, height: 50.0}
    draw_rectangle_lines_ex(rectangle, 1, %{r: 0, g: 255, b: 0, a: 255})
  end

  def midi_in(input) do
    receive do
      {^input, [{{176, 33, 65}, _}]} ->
        IO.inspect("右")

      {^input, [{{176, 33, 63}, _}]} ->
        IO.inspect("左")
    end

    midi_in(input)
  end
end
