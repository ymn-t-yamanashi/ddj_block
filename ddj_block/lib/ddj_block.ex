defmodule DdjBlock do
  @moduledoc """
  Documentation for `DdjBlock`.
  """
  alias Rayex.Structs.Rectangle
  use Rayex
  alias Socket.Web

  def main() do
    s = Web.connect!("localhost", 4000, path: "/socket/websocket?token=undefined&vsn=2.0.0")

    s
    |> join()

    Task.async(fn ->
      loop(s)
    end)

    # {_, input} = PortMidi.open(:input, "DDJ-FLX4 MIDI 1")
    # PortMidi.listen(input, self())
    # midi_in(input)
    # PortMidi.close(:input, input)
    init_window(800, 800, "DdjBlock")
    main_loop(true)
  end

  def loop(s) do
    IO.inspect("----------------------")

    Socket.Web.recv!(s)
    |> IO.inspect()

    loop(s)
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

  # def midi_in(input) do
  #   receive do
  #     {^input, [{{176, 33, 65}, _}]} ->
  #       IO.inspect("右")
  #       midi_in(input)
  #     {^input, [{{176, 33, 63}, _}]} ->
  #       IO.inspect("左")
  #       midi_in(input)
  #     a ->
  #       IO.inspect(a)
  #       midi_in(input)
  #   end
  # end

  def send_data(socket, data) do
    data = """
    ["3","4","ddj:lobby","new_msg",{"body":"#{data}"}]
    """

    Web.send!(socket, {:text, data})
    Process.sleep(250)
    socket
  end

  def join(socket) do
    phx_join = """
    ["3","3","ddj:lobby","phx_join",{}]
    """

    Web.send!(socket, {:text, phx_join})
    socket
  end
end
