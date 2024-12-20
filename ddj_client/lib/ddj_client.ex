defmodule DdjClient do
  @moduledoc """
  Documentation for `DdjClient`.
  """

  alias Socket.Web

  def hello do
    socket =
      Web.connect!("localhost", 4000, path: "/socket/websocket?token=undefined&vsn=2.0.0")
      |> join()

    {_, input} = PortMidi.open(:input, "DDJ-FLX4 MIDI 1")
    PortMidi.listen(input, self())
    midi_in(input, socket)
    PortMidi.close(:input, input)

    :world
  end

  def midi_in(input, socket) do
    receive do
      v ->
        jog(v, socket)
    end

    midi_in(input, socket)
  end

  def jog({_, [{{176, 33, 65}, _}]}, socket) do
    IO.inspect("右 1")
    send_data(socket, "1.0")
  end

  def jog({_, [{{176, 33, 63}, _}]}, socket) do
    IO.inspect("左 -1")
    send_data(socket, "-1.0")
  end

  def jog(_, _) do
    nil
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
end
