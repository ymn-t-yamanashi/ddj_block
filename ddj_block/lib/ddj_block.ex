defmodule DdjBlock do
  @moduledoc """
  Documentation for `DdjBlock`.
  """
  alias Rayex.Structs.Rectangle
  use Rayex
  alias Socket.Web

  @sleep 10
  @color %{r: 0, g: 255, b: 0, a: 255}

  def main() do
    Agent.start_link(fn -> 400.0 end, name: __MODULE__)
    socket = Web.connect!("localhost", 4000, path: "/socket/websocket?token=undefined&vsn=2.0.0")

    socket
    |> join()

    Task.async(fn ->
      socket_loop(socket)
    end)

    init_window(800, 800, "DdjBlock")
    main_loop(true, nil)
  end

  def socket_loop(socket) do
    {_, text} = Socket.Web.recv!(socket)

    text
    |> Jason.decode!()
    |> Enum.at(4)
    |> Map.get("body", "0.0")
    |> String.to_float()
    |> add_state()

    socket_loop(socket)
  end

  defp main_loop(true, data) do
    data = Block.main(data)
    draw_list = data.wall ++ data.blocks ++ data.player ++ data.ball

    begin_drawing()
    clear_background(%{r: 0, g: 0, b: 0, a: 0})
    draw(draw_list)
    end_drawing()

    Process.sleep(@sleep)
    main_loop(!window_should_close(), data)
  end

  defp main_loop(_, data), do: nil

  defp draw() do
    rectangle = %Rectangle{x: get_state(), y: 700.0, width: 100.0, height: 50.0}
    draw_rectangle_lines_ex(rectangle, 1, @color)
  end

  defp draw(draw_list) do
    draw_list
    |> Enum.each(fn draw ->
      [x, y, w, h] = draw
      rectangle = %Rectangle{x: x, y: y, width: w, height: h}
      draw_rectangle_lines_ex(rectangle, 1, @color)
    end)
  end

  def send_data(socket, data) do
    data = """
    ["3","4","ddj:lobby","new_msg",{"body":"#{data}"}]
    """

    Web.send!(socket, {:text, data})
    socket
  end

  def join(socket) do
    phx_join = """
    ["3","3","ddj:lobby","phx_join",{}]
    """

    Web.send!(socket, {:text, phx_join})
    socket
  end

  def get_state, do: Agent.get(__MODULE__, & &1)

  def add_state(v) do
    st = get_state()
    Agent.update(__MODULE__, fn _ -> st + v * 10 end)
  end
end
